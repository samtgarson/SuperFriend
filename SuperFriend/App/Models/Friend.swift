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

    @Transient
    var persisted: Bool = true

    init(
        contactIdentifier: String,
        period: Period = .monthly,
        persisted: Bool = true,
        connectionEvents: [ConnectionEvent] = [],
        repo: ContactDataRepository = ContactDataRepository()
    ) {
        self.createdAt = Date.now
        self.contactIdentifier = contactIdentifier
        self.period = period
        self.persisted = persisted
        self.connectionEvents = connectionEvents
        self.repo = repo
    }

    @MainActor static func fromContactId(
        _ contactId: String,
        friendRepo: ModelRepository<Friend> = ModelRepository()
    ) -> Friend {
        let predicate = #Predicate<Friend> { friend in friend.contactIdentifier == contactId }

        if let found = try? friendRepo.find(with: predicate ) {
            found.persisted = true
            return found
        }

        return Friend(contactIdentifier: contactId, persisted: false)
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
