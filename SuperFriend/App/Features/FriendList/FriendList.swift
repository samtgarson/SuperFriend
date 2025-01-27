//
//  FriendList.swift
//  SuperFriend
//
//  Created by Sam Garson on 17/01/2025.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query() var friends: [Friend]
    @Binding var searchText: String
    var onSelect: ((Friend) -> Void)?
    var onRecordConnection: ((Friend) -> Void)?

    var body: some View {
        List {
            ForEach(sortedFriends, content: row)
        }
        .listStyle(.plain)
        .listRowSpacing(.xs)
    }

    private func row(_ friend: Friend) -> some View {
        FriendListRow(
            friend: friend,
            onSelect: { onSelect?(friend) },
            onRecordConnection: { onRecordConnection?(friend) }
        )
    }

    private var sortedFriends: [Friend] {
        friends
            .filter { friend in
                guard !searchText.isEmpty else { return true }
                guard let fullName = friend.fullName else { return false }

                return fullName.localizedCaseInsensitiveContains(searchText)
            }
            .sorted(by: { lhs, rhs in
            if let lDate = lhs.daysUntilDue, let rDate = rhs.daysUntilDue {
                return lDate < rDate
            }

            if lhs.daysUntilDue != nil { return true }
            if rhs.daysUntilDue != nil { return false }

            if let lContact = lhs.contact, let rContact = rhs.contact {
                return ContactDataRepository.sortComparator(lContact, rContact)
            }

            return true
        })
    }
}

#Preview {
    @Previewable @State var searchText: String = ""

    VStack {
        TextField(
            "Search",
            text: $searchText.animation(.easeOut(duration: .transition))
        ).padding()
        FriendList(
            searchText: $searchText,
            onSelect: { friend in print("Selected \(friend)")}
        )
    }
        .modelContainer(PreviewData.databaseInstance.container)
}
