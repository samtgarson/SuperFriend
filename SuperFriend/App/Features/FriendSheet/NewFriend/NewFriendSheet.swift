//
//  NewFriendSheet.swift
//  SuperFriend
//
//  Created by Claude Code on 25/12/2025.
//

import SwiftUI

struct NewFriendSheet: View {
    let contact: ContactData
    let onIntent: (NewFriendIntent) -> Void

    @State private var selectedPeriod: Period = .monthly
    @State private var lastContacted: Date = .now

    var body: some View {
        VStack(alignment: .leading, spacing: .md) {
            FriendProfile(contact: contact, period: $selectedPeriod)

            Box {
                DatePicker(
                    "Last contacted?",
                    selection: $lastContacted,
                    in: ...Date.now,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close", systemImage: "xmark") {
                    onIntent(.dismiss)
                }
                .font(.caption)
                .buttonStyle(.naked)
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    onIntent(.save(period: selectedPeriod, lastContacted: lastContacted))
                }
                .buttonStyle(.glassProminent)
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    NavigationStack {
        NewFriendSheet(
            contact: PreviewData.contactData[0],
            onIntent: { intent in print(intent) }
        )
    }
}
