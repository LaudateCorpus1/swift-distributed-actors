// ==== ------------------------------------------------------------------ ====
// === DO NOT EDIT: Generated by GenActors                     
// ==== ------------------------------------------------------------------ ====

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

// tag::imports[]

import DistributedActors

// end::imports[]

import DistributedActorsTestKit
import XCTest

// ==== ----------------------------------------------------------------------------------------------------------------
// MARK: DO NOT EDIT: Codable conformance for GeneratedActor.Messages.Diagnostics
// TODO: This will not be required, once Swift synthesizes Codable conformances for enums with associated values 

extension GeneratedActor.Messages.Diagnostics: Codable {
    // TODO: Check with Swift team which style of discriminator to aim for
    public enum DiscriminatorKeys: String, Decodable {
        case printDiagnostics

    }

    public enum CodingKeys: CodingKey {
        case _case

    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(DiscriminatorKeys.self, forKey: CodingKeys._case) {
        case .printDiagnostics:
            self = .printDiagnostics

        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .printDiagnostics:
            try container.encode(DiscriminatorKeys.printDiagnostics.rawValue, forKey: CodingKeys._case)

        }
    }
}
