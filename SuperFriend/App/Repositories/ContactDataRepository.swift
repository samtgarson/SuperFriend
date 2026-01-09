//
//  ContactDataRepository.swift
//  SuperFriend
//
//  Created by Sam Garson on 17/01/2025.
//

import Contacts

class ContactDataRepository: ObservableObject {
    private let store = CNContactStore()
    private let keys = [
        CNContactGivenNameKey,
        CNContactFamilyNameKey,
        CNContactOrganizationNameKey,
        CNContactImageDataKey,
        CNContactPhoneNumbersKey
    ] as [CNKeyDescriptor]

    static func sortComparator(_ lhs: ContactData, _ rhs: ContactData) -> Bool {
        switch CNContactsUserDefaults.shared().sortOrder {
        case .familyName:
            return lhs.familyName < rhs.familyName
        default:
            return lhs.givenName < rhs.givenName
        }
    }

    func authorizationStatus() -> CNAuthorizationStatus {
        return CNContactStore.authorizationStatus(for: .contacts)
    }

    func requestAccess(_ onSuccess: @escaping () -> Void) {
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                onSuccess()
            } else if let error = error {
                print("Error requesting contact access: \(error)")
            }
        }
    }

    func fetchContact(with id: String) -> ContactData? {
        do {
            let contact = try store.unifiedContact(withIdentifier: id, keysToFetch: keys)
            return toContactData(contact)
        } catch {
            print("Failed to fetch contacts: \(error)")
            return nil
        }
    }

    func fetchContacts(search: String? = nil) -> [ContactData] {
        do {
            var predicate: NSPredicate
            if let search = search, !search.isEmpty {
                predicate = CNContact.predicateForContacts(matchingName: search)
            } else {
                predicate = NSPredicate(value: true)
            }

            return try store.unifiedContacts(matching: predicate, keysToFetch: keys)
                .map(toContactData)
                .sorted(by: ContactDataRepository.sortComparator)

        } catch {
            print("Error on contact fetching\(error)")
            return []
        }
    }

    private func toContactData(_ contact: CNContact) -> ContactData {
        .init(
            givenName: contact.givenName,
            familyName: contact.familyName,
            imageData: contact.imageData,
            organizationName: contact.organizationName,
            identifier: contact.identifier,
            phoneNumber: contact.phoneNumbers.first?.value.stringValue
        )
    }
}

class TestContactDataRepository: ContactDataRepository {
    var dummyContacts: [ContactData]

    init(dummyContacts: [ContactData] = [ContactData]()) {
        self.dummyContacts = dummyContacts
    }

    override func authorizationStatus() -> CNAuthorizationStatus {
        return .authorized
    }

    override func requestAccess(_ onSuccess: @escaping () -> Void) {
        onSuccess()
    }

    override func fetchContact(with id: String) -> ContactData? {
        return dummyContacts.first(where: { contact in contact.identifier == id })
    }

    override func fetchContacts(search: String?) -> [ContactData] {
        guard let search = search, !search.isEmpty else { return dummyContacts }

        return dummyContacts.filter { contact in
            contact.familyName.localizedStandardContains(search)
            || contact.givenName.localizedStandardContains(search)
        }
    }
}
