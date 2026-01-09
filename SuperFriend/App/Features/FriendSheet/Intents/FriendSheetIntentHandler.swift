//
//  FriendSheetIntentHandler.swift
//  SuperFriend
//
//  Created by Claude Code on 25/12/2025.
//

import Foundation
import UIKit

@MainActor
class FriendSheetIntentHandler {
    private let friendRepo: ModelRepository<Friend>
    private let eventRepo: ModelRepository<ConnectionEvent>

    init(
        friendRepo: ModelRepository<Friend> = .init(),
        eventRepo: ModelRepository<ConnectionEvent> = .init()
    ) {
        self.friendRepo = friendRepo
        self.eventRepo = eventRepo
    }

    // MARK: - New Friend Handling

    func handle(_ intent: NewFriendIntent, contact: ContactData) throws -> SideEffect? {
        switch intent {
        case .save(let period, let lastContacted):
            let friend = Friend(contactIdentifier: contact.identifier, period: period)
            let event = ConnectionEvent(friend: friend, eventType: .meetUp, tookPlaceAt: lastContacted)
            event.initialContact = true
            friend.connectionEvents.append(event)
            try friendRepo.upsert(friend)
            return .dismissSheet

        case .dismiss:
            return .dismissSheet
        }
    }

    // MARK: - Friend Details Handling

    func handle(_ intent: FriendDetailsIntent, friend: Friend) throws -> SideEffect? {
        switch intent {
        case .dismiss:
            return .dismissSheet

        case .delete:
            try friendRepo.delete(friend)
            return .dismissSheet

        case .updatePeriod(let period):
            friend.period = period
            try friendRepo.upsert(friend)
            return nil

        case .recordConnection(let type):
            let event = ConnectionEvent(friend: friend, eventType: type)
            friend.connectionEvents.append(event)
            try eventRepo.upsert(event)
            return nil

        case .initiateMessage:
            let event = ConnectionEvent(friend: friend, eventType: .message)
            friend.connectionEvents.append(event)
            try eventRepo.upsert(event)
            return .openMessages(friend: friend)

        case .initiateCall:
            let event = ConnectionEvent(friend: friend, eventType: .call)
            friend.connectionEvents.append(event)
            try eventRepo.upsert(event)
            return .openPhone(friend: friend)
        }
    }

    // MARK: - Side Effects

    enum SideEffect {
        case dismissSheet
        case openMessages(friend: Friend)
        case openPhone(friend: Friend)
    }
}

// MARK: - Side Effect Execution

extension FriendSheetIntentHandler {
    func execute(_ effect: SideEffect, navigation: AppNavigation) {
        switch effect {
        case .dismissSheet:
            navigation.dismissSheet()

        case .openMessages(let friend):
            if let phone = friend.contact?.phoneNumber,
               let url = URL(string: "sms:\(phone)") {
                UIApplication.shared.open(url)
            }

        case .openPhone(let friend):
            if let phone = friend.contact?.phoneNumber,
               let url = URL(string: "tel:\(phone)") {
                UIApplication.shared.open(url)
            }
        }
    }
}
