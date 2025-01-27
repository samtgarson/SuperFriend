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
final class Friend: Identifiable {
    var contactIdentifier: String
    var period: Period
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \ConnectionEvent.friend)
    var connectionEvents: [ConnectionEvent]

    @Transient
    private var repo = ContactDataRepository()

    init(
        contactIdentifier: String,
        period: Period = .monthly,
        connectionEvents: [ConnectionEvent] = [],
        repo: ContactDataRepository = ContactDataRepository()
    ) {
        self.createdAt = Date.now
        self.contactIdentifier = contactIdentifier
        self.period = period
        self.connectionEvents = connectionEvents
        self.repo = repo
    }

    var contact: ContactData? {
        repo.fetchContact(with: contactIdentifier)
    }

    var fullName: String? {
        guard let contact = contact else { return nil }

        return "\(contact.givenName) \(contact.familyName)"
    }

    var lastConnectedDate: Date? {
        sortedConnectionEvents.first?.tookPlaceAt
    }

    var daysUntilDue: Int? {
        guard let lastConnected = lastConnectedDate else { return nil }

        return period.days - Calendar.current.numberOfDays(between: lastConnected, and: Date.now)
    }

    private var sortedConnectionEvents: [ConnectionEvent] {
        connectionEvents.sorted(by: { lhs, rhs in
            return lhs.tookPlaceAt < rhs.tookPlaceAt
        })
    }
}
