//
//  EditContactScreen.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

import SwiftUI
import SwiftData

struct EditContactScreen: View {
    var onComplete: () -> Void
    @StateObject var viewModel: EditContactScreenViewModel

    init(friend: Friend, contact: ContactData, onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
        self._viewModel = StateObject(wrappedValue: .init(contact: contact, friend: friend))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: .md) {
                avatar
                VStack(spacing: .xs) {
                    Text(viewModel.fullName).bold().font(.title3)
                    if !viewModel.orgName.isEmpty {
                        Text(viewModel.orgName).opacity(.opacityBodyText)
                    }
                    Picker("How often do you keep in touch?", selection: $viewModel.selectedPeriod) {
                        ForEach(viewModel.choices) { choice in
                            Text(choice.label).tag(choice)
                        }
                    }
                    
                }
                AsyncButton(
                    action: {
                        try viewModel.complete()
                        onComplete()
                    },
                    label: { Text("Save") }
                ).buttonStyle(.primary)
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem { backButton }
            }
        }
    }

    private var avatar: some View {
        Avatar(from: viewModel.contact, size: 130)
    }

    private var backButton: some View {
        Button("Back", systemImage: "xmark") { onComplete() }
            .font(.caption)
            .buttonStyle(.secondary)
    }

}

#Preview {
    var contact = ContactData(
        givenName: "Sam",
        familyName: "Garson",
        organizationName: "Progression",
        identifier: "123"
    )
    var friend = Friend(contactIdentifier: "123", period: .annually)
    var container = Database.testInstance().container

    VStack {
        EditContactScreen(
            friend: friend,
            contact: contact,
            onComplete: { print("Completed") }
        )
    }.modelContainer(container)
}
