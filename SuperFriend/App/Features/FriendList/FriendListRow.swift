//
//  FriendListRow.swift
//  SuperFriend
//
//  Created by Sam Garson on 17/01/2025.
//

import SwiftUI
import SwiftData

struct FriendListRow: View {
    var friend: Friend
    var onSelect: (() -> Void)?
    var onRecordConnection: (() -> Void)?

    init(
        friend: Friend,
        onSelect: ( () -> Void)? = nil,
        onRecordConnection: ( () -> Void)? = nil
    ) {
        self.friend = friend
        self.onSelect = onSelect
        self.onRecordConnection = onRecordConnection
    }

    var body: some View {
        HStack(spacing: .xs) {
            avatar
            VStack(alignment: .leading) {
                title
                days.opacity(.opacitySlightlyFaded)
            }
            Spacer()
        }
        .padding(.vertical, .xs)
        .listRowSeparator(.hidden)
        .listRowBackground(RoundedRectangle(cornerRadius: .cornerRadius)
            .opacity(.opacityVeryFaded)
        )
        .swipeActions(allowsFullSwipe: false) { swipeAction }
        .contentShape(Rectangle())
        .onTapGesture { onSelect?() }
    }

    private var avatar: some View {
        Avatar(from: friend.contact)
    }

    @ViewBuilder
    private var days: some View {
        if let days = friend.daysUntilDue {
            if days < 1 {
                Text("Due")
            } else {
                Text("\(days) days")
            }
        }
    }

    private var title: some View {
        if let fullName = friend.fullName {
            Text(fullName).bold().opacity(1)
        } else {
            Text(friend.contactIdentifier)
                .bold()
                .italic()
                .opacity(.opacityBodyText)
        }
    }

    private var swipeAction: some View {
        Button(
            action: { onRecordConnection?() },
            label: { SwipeIcon(systemName: "hand.wave.fill") }
        )
        .tint(.init(.background))
    }
}

#Preview {
    List {
        ForEach(PreviewData.friends, id: \.contactIdentifier) { friend in
            FriendListRow(
                friend: friend,
                onSelect: { print("Selected") },
                onRecordConnection: { print("Recorded") }
            )
        }
    }
    .listStyle(.plain)
    .listRowSpacing(.xs)
    .modelContainer(PreviewData.databaseInstance.container)
}
