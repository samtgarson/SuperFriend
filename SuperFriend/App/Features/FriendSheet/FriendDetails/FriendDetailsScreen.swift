//
//  FriendDetailsScreen.swift
//  SuperFriend
//
//  Created by Claude Code on 23/01/2025.
//

import SwiftUI

struct FriendDetailsScreen: View {
    enum FriendDetailScreenAction {
        case done
        case edit
        case remove
        case message
        case call
        case contactMade
    }

    let friend: Friend
    let contact: ContactData
    var onAction: (FriendDetailScreenAction) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: .md) {
            Avatar(from: contact, size: 130)

            VStack(spacing: .xs) {
                Text(contact.fullName).bold().font(.title)
                if !contact.organizationName.isEmpty {
                    Text(contact.organizationName).opacity(.opacityBodyText)
                }
            }

            VStack(spacing: .sm) {
                HStack(spacing: .sm) {
                    Button("Message") { onAction(.message) }
                        .with(icon: "message.fill")
                        .buttonStyle(.secondary)
                    Button("Call") { onAction(.call) }
                        .with(icon: "phone.fill")
                        .buttonStyle(.secondary)
                }
                Button("I made contact") { onAction(.contactMade) }
                    .with(icon: "checkmark.circle.fill")
                    .buttonStyle(.secondary)
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close", systemImage: "xmark") { onAction(.done) }
                .font(.caption)
                .buttonStyle(.naked)
            }
            ToolbarItem(placement: .secondaryAction) {
                Button("Edit", systemImage: "pencil") { onAction(.edit) }
            }
            ToolbarItem(placement: .secondaryAction) {
                Button("Remove", systemImage: "trash", role: .destructive) { onAction(.remove) }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    let friend = Friend(contactIdentifier: "123", period: .monthly)
    let contact = ContactData(
        givenName: "Alice",
        familyName: "Smith",
        organizationName: "Acme Inc",
        identifier: "123"
    )

    NavigationStack {
        FriendDetailsScreen(
            friend: friend,
            contact: contact,
            onAction: { action in print(action) }
        )
    }
}
