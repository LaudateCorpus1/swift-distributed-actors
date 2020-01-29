//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Distributed Actors open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift Distributed Actors project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.md for the list of Swift Distributed Actors project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import XCTest

///
/// NOTE: This file was generated by generate_linux_tests.rb
///
/// Do NOT edit this file directly as it will be regenerated automatically when needed.
///

extension MembershipGossipTests {
    static var allTests: [(String, (MembershipGossipTests) -> () throws -> Void)] {
        return [
            ("test_mergeForward_incomingGossip_firstGossipFromOtherNode", test_mergeForward_incomingGossip_firstGossipFromOtherNode),
            ("test_mergeForward_incomingGossip_firstGossipFromOtherNodes", test_mergeForward_incomingGossip_firstGossipFromOtherNodes),
            ("test_mergeForward_incomingGossip_sameVersions", test_mergeForward_incomingGossip_sameVersions),
            ("test_mergeForward_incomingGossip_fromFourth_onlyKnowsAboutItself", test_mergeForward_incomingGossip_fromFourth_onlyKnowsAboutItself),
            ("test_mergeForward_incomingGossip_localHasRemoved_incomingHasOldViewWithDownNode", test_mergeForward_incomingGossip_localHasRemoved_incomingHasOldViewWithDownNode),
            ("test_mergeForward_incomingGossip_concurrent_leaderDisagreement", test_mergeForward_incomingGossip_concurrent_leaderDisagreement),
            ("test_mergeForward_incomingGossip_concurrent_simple", test_mergeForward_incomingGossip_concurrent_simple),
            ("test_mergeForward_incomingGossip_hasNewNode", test_mergeForward_incomingGossip_hasNewNode),
            ("test_mergeForward_removal_incomingGossip_isAhead_hasRemovedNodeKnownToBeDown", test_mergeForward_removal_incomingGossip_isAhead_hasRemovedNodeKnownToBeDown),
            ("test_mergeForward_incomingGossip_removal_isAhead_hasMyNodeRemoved_thusWeKeepItAsRemoved", test_mergeForward_incomingGossip_removal_isAhead_hasMyNodeRemoved_thusWeKeepItAsRemoved),
            ("test_converged_shouldBeTrue_forNoMembers", test_converged_shouldBeTrue_forNoMembers),
            ("test_converged_amongUpMembers", test_converged_amongUpMembers),
            ("test_converged_othersAreOnlyDown", test_converged_othersAreOnlyDown),
            ("test_converged_joiningOrDownMembersDoNotCount", test_converged_joiningOrDownMembersDoNotCount),
            ("test_gossip_eventuallyConverges", test_gossip_eventuallyConverges),
        ]
    }
}
