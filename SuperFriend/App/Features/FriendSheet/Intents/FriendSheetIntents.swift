//
//  FriendSheetIntents.swift
//  SuperFriend
//
//  Created by Claude Code on 24/12/2025.
//

import Foundation

// MARK: - New Friend Flow

enum NewFriendIntent {
    case save(period: Period, lastContacted: Date)
    case dismiss
}

// MARK: - Friend Details Flow

enum FriendDetailsIntent {
    case dismiss
    case delete
    case updatePeriod(Period)
    case recordConnection(ConnectionEvent.ConnectionEventType)
    case initiateMessage
    case initiateCall
}
