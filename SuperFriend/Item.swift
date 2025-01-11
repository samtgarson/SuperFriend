//
//  Item.swift
//  SuperFriend
//
//  Created by Sam Garson on 11/01/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
