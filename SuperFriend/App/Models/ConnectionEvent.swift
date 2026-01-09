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
    var initialContact: Bool = false

    enum ConnectionEventType: String, Codable, CaseIterable, Identifiable {
        var id: String { label }

        case message
        case call
        case meetUp

        var iconName: String {
            switch self {
            case .message: "message.fill"
            case .call: "phone.fill"
            case .meetUp: "person.2.fill"
            }
        }

        var label: String {
            switch self {
            case .message: "Message"
            case .call: "Call"
            case .meetUp: "Meet up"
            }
        }
    }

    init(friend: Friend, eventType: ConnectionEventType = .meetUp, tookPlaceAt: Date = Date.now) {
        self.friend = friend
        self.eventType = eventType
        self.tookPlaceAt = tookPlaceAt
    }
}
