//
//  AppRoutes.swift
//  SuperFriend
//
//  Created by Sam Garson on 13/01/2025.
//

import Contacts
import Routing
import SwiftUI

typealias AppRouter = Router<AppRoutes>

enum AppRoutes: Routable {
    case friendList
    case contactPicker
    case editFriend(Friend)
    case newFriend(ContactData)

    @ViewBuilder
    func viewToDisplay(router: Router<AppRoutes>) -> some View {
        switch self {
        case .friendList:
            FriendListScreen(router: router)
        case .contactPicker:
            ContactPickerScreen(router: router)
        case .newFriend(let contact):
            EditContactScreen.fromContact(contact: contact, onComplete: { router.dismissSelf() })
        case .editFriend(let friend):
            if let contact = friend.contact {
                EditContactScreen(
                    friend: friend,
                    contact: contact,
                    onComplete: { router.dismissSelf() }
                )
            } else {
                VStack {
                    Text("Not Found, friend: \(friend.contactIdentifier)")
                    Button("Back") { router.dismissChild() }
                }
            }
        }
    }
}
