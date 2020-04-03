// ==== ------------------------------------------------------------------ ====
// === DO NOT EDIT: Generated by GenActors                     
// ==== ------------------------------------------------------------------ ====

//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Distributed Actors open source project
//
// Copyright (c) 2019 Apple Inc. and the Swift Distributed Actors project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.md for the list of Swift Distributed Actors project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import DistributedActors

// ==== ----------------------------------------------------------------------------------------------------------------
// MARK: DO NOT EDIT: Codable conformance for TestActorableNamespace.InnerNamespace.TestActorableNamespaceExtensionEnumDirectly.Message
// TODO: This will not be required, once Swift synthesizes Codable conformances for enums with associated values 

extension TestActorableNamespace.InnerNamespace.TestActorableNamespaceExtensionEnumDirectly.Message {
    // TODO: Check with Swift team which style of discriminator to aim for
    public enum DiscriminatorKeys: String, Decodable {
        case echo

    }

    public enum CodingKeys: CodingKey {
        case _case
        case echo_string
        case echo__replyTo

    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(DiscriminatorKeys.self, forKey: CodingKeys._case) {
        case .echo:
            let string = try container.decode(String.self, forKey: CodingKeys.echo_string)
            let _replyTo = try container.decode(ActorRef<String>.self, forKey: CodingKeys.echo__replyTo)
            self = .echo(string, _replyTo: _replyTo)

        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .echo(let string, let _replyTo):
            try container.encode(DiscriminatorKeys.echo.rawValue, forKey: CodingKeys._case)
            try container.encode(string, forKey: CodingKeys.echo_string)
            try container.encode(_replyTo, forKey: CodingKeys.echo__replyTo)

        }
    }
}
