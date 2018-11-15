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


import NIOConcurrencyHelpers
import Swift Distributed ActorsActor

import XCTest

final public class ActorTestKit {

  private let system: ActorSystem

  public init(system: ActorSystem) {
    self.system = system
  }

}