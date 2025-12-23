//
//  SuperFriendApp.swift
//  SuperFriend
//
//  Created by Sam Garson on 11/01/2025.
//

import SwiftData
import SwiftUI

@main
struct SuperFriendApp: App {
    var body: some Scene {
        WindowGroup {
            AppRouterView()
                .onAppear {
                    let config = UIImage.SymbolConfiguration(weight: .light)
                    UINavigationBar
                        .appearance().backIndicatorImage = UIImage(
                            systemName: "chevron.left",
                            withConfiguration: config
                        )
                    UINavigationBar
                        .appearance().backIndicatorTransitionMaskImage = UIImage(
                            systemName: "chevron.left",
                            withConfiguration: config
                        )
                }
        }
        .modelContainer(Database.instance.container)
    }
}
