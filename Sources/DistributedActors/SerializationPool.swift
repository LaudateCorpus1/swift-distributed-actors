//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Distributed Actors open source project
//
// Copyright (c) 2018-2019 Apple Inc. and the Swift Distributed Actors project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.md for the list of Swift Distributed Actors project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import NIO

/// A pool of serialization worker threads which perform (de)serialization of messages potentially in parallel.
/// The main purpose of doing so rather than serializing directly inside the calling thread (e.g. the event loop)
/// is offloading serializing potentially "heavy" messages from others which are small and quick to (de)serialize.
///
/// Conceptually serialization is performed on dedicated "lanes" which correspond to the recipient of the message.
/// Dedicated lanes for recipient actors can be configured using `SerializationPoolSettings`.
/// // TODO the scheme how we configure this may need some more re-thinking.
///
/// Dispatching serialization to workers comes with a latency hit, as more async-processing has to happen to perform the
/// same amount of work, however it allows avoiding head-of-line blocking in presence of large messages, e.g. when typically
/// a given set of actors often sends large messages, which would have otherwise stalled the sending of other high-priority
/// (e.g. system) messages.
internal final class SerializationPool {
    @usableFromInline
    internal let serialization: Serialization
    @usableFromInline
    internal let workerMapping: [ActorPath: Int]
    @usableFromInline
    internal let serializationWorkerPool: AffinityThreadPool
    @usableFromInline
    internal let deserializationWorkerPool: AffinityThreadPool

    internal init(settings: SerializationPoolSettings, serialization: Serialization) throws {
        self.serialization = serialization
        var workerMapping: [ActorPath: Int] = [:]
        for (index, group) in settings.serializationGroups.enumerated() {
            for path in group {
                // mapping from each actor path to the corresponding group index,
                // which maps 1:1 to the serialization worker number
                workerMapping[path] = index
            }
        }
        self.workerMapping = workerMapping
        self.serializationWorkerPool = try AffinityThreadPool(workerCount: settings.serializationGroups.count)
        self.deserializationWorkerPool = try AffinityThreadPool(workerCount: settings.serializationGroups.count)
    }

    deinit {
        self.shutdown()
    }

    internal func shutdown() {
        self.serializationWorkerPool.shutdown()
    }

    @inlinable
    internal func serialize<M>(message: M, recipientPath: ActorPath, promise: EventLoopPromise<ByteBuffer>) {
        self.enqueue(recipientPath: recipientPath, promise: promise, workerPool: self.serializationWorkerPool) {
            try self.serialization.serialize(message: message)
        }
    }

    @inlinable
    internal func serialize(message: Any, metaType: AnyMetaType, recipientPath: ActorPath, promise: EventLoopPromise<(Serialization.SerializerId, ByteBuffer)>) {
        self.enqueue(recipientPath: recipientPath, promise: promise, workerPool: self.serializationWorkerPool) {
            try self.serialization.serialize(message: message, metaType: metaType)
        }
    }

    @inlinable
    internal func deserialize<M>(_ type: M.Type, from bytes: ByteBuffer, recipientPath: ActorPath, promise: EventLoopPromise<M>) {
        // TODO: bytes to become inout?
        self.enqueue(recipientPath: recipientPath, promise: promise, workerPool: self.deserializationWorkerPool) {
            try self.serialization.deserialize(type, from: bytes)
        }
    }

    @inlinable
    internal func deserialize(serializerId: Serialization.SerializerId, from bytes: ByteBuffer, recipientPath: ActorPath, promise: EventLoopPromise<Any>) {
        // TODO: bytes to become inout?
        self.enqueue(recipientPath: recipientPath, promise: promise, workerPool: self.deserializationWorkerPool) {
            try self.serialization.deserialize(serializerId: serializerId, from: bytes)
        }
    }

    private func enqueue<T>(recipientPath: ActorPath, promise: EventLoopPromise<T>, workerPool: AffinityThreadPool, task: @escaping () throws -> T) {
        do {
            // check if messages for this particular actor should be handled
            // on a separate thread and submit to the worker pool
            if let workerNumber = self.workerMapping[recipientPath] {
                try workerPool.execute(on: workerNumber) {
                    do {
                        let result = try task()
                        promise.succeed(result)
                    } catch {
                        promise.fail(error)
                    }
                }
            } else { // otherwise handle on the calling thread
                promise.succeed(try task())
            }
        } catch {
            promise.fail(error)
        }
    }
}

// ==== ----------------------------------------------------------------------------------------------------------------
// MARK: SerializationSettings

public struct SerializationPoolSettings {
    public let serializationGroups: [[ActorPath]]

    internal static var `default`: SerializationPoolSettings {
        return SerializationPoolSettings(serializationGroups: [])
    }
}