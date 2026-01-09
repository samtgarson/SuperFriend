//
//  FriendDetailsScreen.swift
//  SuperFriend
//
//  Created by Claude Code on 23/01/2025.
//

import SwiftUI

struct FriendDetailsScreen: View {
    let friend: Friend
    let contact: ContactData
    let onIntent: (FriendDetailsIntent) -> Void

    @State private var selectedPeriod: Period
    @State private var historyExpanded = false

    init(friend: Friend, contact: ContactData, onIntent: @escaping (FriendDetailsIntent) -> Void) {
        self.friend = friend
        self.contact = contact
        self.onIntent = onIntent
        self._selectedPeriod = State(initialValue: friend.period)
    }

    var body: some View {
        VStack(alignment: .center, spacing: .md) {
            FriendProfile(contact: contact, period: $selectedPeriod)
                .onChange(of: selectedPeriod) { _, newValue in
                    onIntent(.updatePeriod(newValue))
                }

            VStack(spacing: .sm) {
                HStack(spacing: .sm) {
                    Button("Message") { onIntent(.initiateMessage) }
                        .with(icon: "message.fill", wide: true)
                        .buttonStyle(.secondary)
                    Button("Call") { onIntent(.initiateCall) }
                        .with(icon: "phone.fill", wide: true)
                        .buttonStyle(.secondary)
                }
                Menu {
                    Section("How did you make contact?") {
                        ForEach(ConnectionEvent.ConnectionEventType.allCases) { type in
                            Button(type.label) {
                                onIntent(.recordConnection(type))
                            }
                        }
                    }
                } label: {
                    Button("I made contact") {}
                        .with(icon: "checkmark.circle.fill", wide: true)
                        .buttonStyle(.secondary)
                        .foregroundStyle(.foreground)
                }
            }

            Spacer()
       }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close", systemImage: "xmark") { onIntent(.dismiss) }
                    .font(.caption)
                    .buttonStyle(.naked)
            }
            ToolbarItem(placement: .secondaryAction) {
                Button("Remove", systemImage: "trash", role: .destructive) { onIntent(.delete) }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    let friend = PreviewData.friends[0]
    let contact = friend.contact!

    NavigationStack {
        FriendDetailsScreen(
            friend: friend,
            contact: contact,
            onIntent: { intent in print(intent) }
        )
    }
}
