//
//  AppRouter.swift
//  SuperFriend
//
//  Created by Sam Garson on 24/12/2025.
//

import SwiftUI

struct AppRouter: View {
    @State private var navigation = AppNavigation()
    private let intentHandler = FriendSheetIntentHandler()

    var body: some View {
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
            case .newFriend(let contactData):
                NavigationStack {
                    NewFriendSheet(
                        contact: contactData,
                        onIntent: { intent in
                            if let effect = try? intentHandler.handle(intent, contact: contactData) {
                                intentHandler.execute(effect, navigation: navigation)
                            }
                        }
                    )
                }

            case .friendDetails(let friend):
                if let contact = friend.contact {
                    NavigationStack {
                        FriendDetailsScreen(
                            friend: friend,
                            contact: contact,
                            onIntent: { intent in
                                if let effect = try? intentHandler.handle(intent, friend: friend) {
                                    intentHandler.execute(effect, navigation: navigation)
                                }
                            }
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    AppRouter()
}
