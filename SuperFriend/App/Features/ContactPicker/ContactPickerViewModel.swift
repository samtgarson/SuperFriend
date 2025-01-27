//
//  ContactPickerViewModel.swift
//  SuperFriend
//
//  Created by Sam Garson on 13/01/2025.
//

import SwiftUI
import Contacts

class ContactPickerViewModel: ObservableObject {
    var repo: ContactDataRepository
    @Published var contacts = [ContactData]()
    @Published var searchText = "" {
        didSet { withAnimation(.easeOut(duration: .transition)) { fetchContacts() } }
    }

    init(repo: ContactDataRepository = ContactDataRepository()) {
        self.repo = repo
        fetchContacts()
    }

    var limitedAccess: Bool {
        let status = repo.authorizationStatus()

        switch status {
        case .authorized:
            return false
        default:
            return true
        }
    }

    var emptySearch: Bool {
        contacts.isEmpty && !searchText.isEmpty
    }

    func openSettings () {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }

    func fetchContacts() {
        let status = repo.authorizationStatus()

        switch status {
        case .authorized, .limited:
            requestContacts(from: repo)
        case .notDetermined:
            repo.requestAccess(fetchContacts)
        default:
            print("noop")
        }
    }

    private func requestContacts(from repo: ContactDataRepository) {
        self.contacts = repo.fetchContacts(search: searchText)
    }
}
