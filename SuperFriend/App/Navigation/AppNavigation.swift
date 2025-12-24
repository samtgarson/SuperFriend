//
//  AppNavigation.swift
//  SuperFriend
//
//  Created by Claude Code on 23/01/2025.
//

import SwiftUI
import SwiftNavigation

@Observable
class AppNavigation {
    var path: [Path] = []

    var activeSheet: ActiveSheet? {
        didSet {
            friendFlowPath = []
        }
    }

    var friendFlowPath: [FriendFlowPath] = []

    @CasePathable
    enum Path: Hashable {
        case contactPicker
        case settings
        #if DEBUG
        case playground
        #endif
    }

    @CasePathable
    enum ActiveSheet: Hashable {
        case friendFlow(friend: Friend?, contactData: ContactData)
    }

    @CasePathable
    enum FriendFlowPath: Hashable {
        case edit
    }
}
