//
//  EditContactScreen.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

import SwiftData
import SwiftUI

struct EditContactScreen: View {
    var onComplete: () -> Void
    var showCloseButton: Bool = false
    @StateObject var viewModel: EditContactScreenViewModel

    init(
        friend: Friend?,
        contact: ContactData,
        onComplete: @escaping () -> Void,
        showCloseButton: Bool = false
    ) {
        self.onComplete = onComplete
        let friend = friend ?? Friend.fromContactId(contact.identifier)
        self._viewModel = StateObject(wrappedValue: .init(contact: contact, friend: friend))
        self.showCloseButton = showCloseButton
    }

    var body: some View {
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
            VStack(spacing: .sm) {
                if viewModel.friend.persisted {
                    AsyncButton(
                        action: {
                            try viewModel.destroy()
                            onComplete()
                        },
                        label: { Text("Remove \(viewModel.contact.givenName)") },
                        role: .destructive
                    ).buttonStyle(.naked)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AsyncButton(
                    action: {
                        try viewModel.save()
                        onComplete()
                    },
                    label: { Text("Save") }
                ).buttonStyle(.glassProminent)
            }
            if showCloseButton {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark", action: onComplete)
                        .font(.caption)
                        .buttonStyle(.naked)
                }
            }
        }
    }

    private var avatar: some View {
        Avatar(from: viewModel.contact, size: 130)
    }
}

#Preview {
    @Previewable @State var showClose = false
    let contact = ContactData(
        givenName: "Sam",
        familyName: "Garson",
        organizationName: "Progression",
        identifier: "123"
    )
    let friend = Friend(contactIdentifier: "123", period: .annually)
    let container = Database.testInstance().container

    NavigationStack {
        VStack {
            EditContactScreen(
                friend: friend,
                contact: contact,
                onComplete: { print("Completed") },
                showCloseButton: showClose
            )
            Toggle("Show Close", isOn: $showClose)
        }.modelContainer(container)
    }
}
