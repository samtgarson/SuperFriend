//
//  SuperFriendApp.swift
//  SuperFriend
//
//  Created by Sam Garson on 11/01/2025.
//

import SwiftData
import SwiftUI
import SwiftUINavigation

@main
struct SuperFriendApp: App {
    @State private var navigation = AppNavigation()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.path) {
                FriendListScreen(navigation: navigation)
                    .navigationDestination(for: AppNavigation.Path.self) { pathCase in
                        switch pathCase {
                        case .contactPicker:
                            ContactPickerScreen(navigation: navigation)
                        case .settings:
                            SettingsScreen(navigation: navigation)
                        #if DEBUG
                        case .playground:
                            PlaygroundScreen(navigation: navigation)
                        #endif
                        }
                    }
            }
            .sheet(item: $navigation.activeSheet, id: \.self) { activeSheet in
                switch activeSheet {
                case .friendFlow(let friend, let contactData):
                    if let friend = friend {
                        // Existing friend: Show details with navigation to edit
                        NavigationStack(path: $navigation.friendFlowPath) {
                            FriendDetailsScreen(
                                friend: friend,
                                contact: contactData,
                                onAction: { action in
                                    switch action {
                                    case .edit:
                                        navigation.friendFlowPath.append(.edit)
                                    case .done:
                                        navigation.activeSheet = nil
                                    case .remove:
                                        print("Removing \(friend)")
                                    }
                                }
                            )
                            .navigationDestination(for: AppNavigation.FriendFlowPath.self) { pathCase in
                                switch pathCase {
                                case .edit:
                                    EditContactScreen(
                                        friend: friend,
                                        contact: contactData,
                                        onComplete: { navigation.friendFlowPath.removeLast() }
                                    )
                                }
                            }
                        }
                    } else {
                        // New friend: Edit screen is the root (no navigation)
                        NavigationStack {
                            EditContactScreen(
                                friend: nil,
                                contact: contactData,
                                onComplete: { navigation.activeSheet = nil },
                                showCloseButton: true
                            )
                        }
                    }
                }
            }
            .onAppear {
                let config = UIImage.SymbolConfiguration(weight: .light)
                UINavigationBar.appearance().backIndicatorImage = UIImage(
                    systemName: "chevron.left",
                    withConfiguration: config
                )
                UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(
                    systemName: "chevron.left",
                    withConfiguration: config
                )
            }
        }
        .modelContainer(Database.instance.container)
    }
}
