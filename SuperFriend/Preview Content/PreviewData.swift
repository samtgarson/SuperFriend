//
//  PreviewData.swift
//  SuperFriend
//
//  Created by Sam Garson on 17/01/2025.
//

import SwiftUI
import SwiftData

struct PreviewData {
    static let contactData = [
        ContactData(
            givenName: "Sam",
            familyName: "Garson",
            organizationName: "Progression",
            identifier: "123"
        ),
        ContactData(
            givenName: "Gabrielle",
            familyName: "Rowan",
            imageData: UIImage(
                systemName: "person.and.background.dotted"
            )?.pngData(),
            organizationName: "Made By On",
            identifier: "456"
        )
    ]

    static let friends = [
        Friend(contactIdentifier: "123", period: .weekly, repo: contactDataRepo),
        Friend(contactIdentifier: "456", period: .everyThreeMonths, repo: contactDataRepo),
        Friend(contactIdentifier: "789", period: .everyTwoMonths, repo: contactDataRepo)
    ]

    static let connectionEvents = [
        ConnectionEvent(friend: friends[0], tookPlaceAt: .yesterday),
        ConnectionEvent(friend: friends[0], tookPlaceAt: .lastWeek),
        ConnectionEvent(friend: friends[1])
    ]

    static let contactDataRepo = TestContactDataRepository(
        dummyContacts: contactData
    )

    @MainActor
    static let databaseInstance = Database.testInstance(with: friends + connectionEvents)
}
