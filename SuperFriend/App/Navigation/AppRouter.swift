//
//  AppRouter.swift
//  SuperFriend
//
//  Created by Sam Garson on 24/12/2025.
//

import SwiftUI

struct AppRouter: View {
    @State private var navigation = AppNavigation()

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
                    EditContactScreen(
                        friend: nil,
                        contact: contactData,
                        onComplete: { navigation.dismissSheet() },
                        showCloseButton: true
                    )
                }
            case .friendFlow(let friend):
                FriendSheetRouter(friend: friend, navigator: navigation)

            }
        }
    }
}

#Preview {
    AppRouter()
}
