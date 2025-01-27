//
//  SuperFriendApp.swift
//  SuperFriend
//
//  Created by Sam Garson on 11/01/2025.
//

import SwiftUI
import SwiftData

@main
struct SuperFriendApp: App {
    var body: some Scene {
        WindowGroup {
            AppRouterView { router in FriendListScreen(router: router) }
        }
        .modelContainer(Database.instance.container)
    }
}
