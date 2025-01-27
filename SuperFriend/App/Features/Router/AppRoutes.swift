//
//  AppRoutes.swift
//  SuperFriend
//
//  Created by Sam Garson on 13/01/2025.
//

import SwiftUI
import Routing
import Contacts

typealias AppRouter = Router<AppRoutes>

enum AppRoutes: Routable {
    case friendList
    case contactPicker
    case editFriend(Friend)

    @ViewBuilder
    func viewToDisplay(router: Router<AppRoutes>) -> some View {
        switch self {
        case .friendList:
            FriendListScreen(router: router)
        case .contactPicker:
            ContactPickerScreen(router: router)
        case .editFriend(let friend):
            if let contact = friend.contact {
                EditContactScreen(friend: friend, contact: contact, onComplete: { router.dismiss() })
            } else {
                VStack {
                    Text("Not Found, friend: \(friend.contactIdentifier)")
                    Button("Back") { router.dismiss() }
                }
            }
        }
    }

    var navigationType: NavigationType {
        switch self {
        case .contactPicker, .editFriend:
                .sheet
        default:
                .push
        }
    }
}
