//
//  EditContactScreenViewModel.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

import SwiftUI

class EditContactScreenViewModel: ObservableObject {
    var friendRepo: ModelRepository<Friend>
    var friend: Friend
    @Published var contact: ContactData
    @Published var selectedPeriod: Period = .monthly

    init(contact: ContactData, friend: Friend, friendRepo: ModelRepository<Friend> = ModelRepository()) {
        self.contact = contact
        self.friend = friend
        self.friendRepo = friendRepo
        self.selectedPeriod = friend.period
    }

    var choices: [Period] {
        Period.allCases
    }

    var fullName: String { contact.fullName }
    var orgName: String { contact.organizationName }

    @MainActor
    func complete() throws {
        friend.period = selectedPeriod
        if friend.connectionEvents.isEmpty {
            let event = ConnectionEvent(friend: friend, tookPlaceAt: .now)
            friend.connectionEvents.append(event)
        }
        try friendRepo.upsert(friend)

        withAnimation {
            friend.persisted = true
        }
    }

    @MainActor func destroy() throws {
        try friendRepo.delete(friend)
    }
}
