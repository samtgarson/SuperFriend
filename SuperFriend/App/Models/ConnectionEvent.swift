//
//  Friend.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

import SwiftUI
import SwiftData
import Contacts

@Model
final class ConnectionEvent: Identifiable {
    @Relationship()
    var friend: Friend
    var tookPlaceAt: Date
    var eventType: ConnectionEventType = ConnectionEventType.message

    enum ConnectionEventType: String, Codable {
        case message
        case meetUp
    }

    init(friend: Friend, eventType: ConnectionEventType = .meetUp, tookPlaceAt: Date = Date.now) {
        self.friend = friend
        self.eventType = eventType
        self.tookPlaceAt = tookPlaceAt
    }
}
