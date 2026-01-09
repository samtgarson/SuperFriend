//
//  ConnectionHistory.swift
//  SuperFriend
//
//  Created by Claude Code on 25/12/2025.
//

import SwiftUI

struct ConnectionHistory: View {
    let events: [ConnectionEvent]
    @Binding var isExpanded: Bool

    private var sortedEvents: [ConnectionEvent] {
        events.sorted { $0.tookPlaceAt > $1.tookPlaceAt }
    }

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading, spacing: .xs) {
                ForEach(sortedEvents) { event in
                    HStack {
                        Image(systemName: event.eventType.iconName)
                            .foregroundStyle(.secondary)
                        Text(event.tookPlaceAt, style: .date)
                        if event.initialContact {
                            Text("(initial)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.vertical, .xs)
                }
            }
        } label: {
            HStack {
                Text("Connection History")
                Text("(\(events.count))")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    @Previewable @State var isExpanded = true

    let friend = Friend(contactIdentifier: "123", period: .monthly)
    let events = [
        ConnectionEvent(friend: friend, eventType: .message, tookPlaceAt: Date.now.addingTimeInterval(-86400)),
        ConnectionEvent(friend: friend, eventType: .call, tookPlaceAt: Date.now.addingTimeInterval(-172800)),
        ConnectionEvent(friend: friend, eventType: .meetUp, tookPlaceAt: Date.now.addingTimeInterval(-604800))
    ]

    ConnectionHistory(events: events, isExpanded: $isExpanded)
        .padding()
}
