//
//  NewContactDataProtocol.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

import Contacts

struct ContactData: Equatable, Hashable {
    var givenName: String
    var familyName: String
    var imageData: Data?
    var organizationName: String
    var identifier: String
    var phoneNumber: String?

    var fullName: String {
        "\(givenName) \(familyName)"
    }
}
