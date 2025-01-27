//
//  Screen.swift
//  SuperFriend
//
//  Created by Sam Garson on 12/01/2025.
//

import SwiftUI

struct FriendListScreen: View {
    @StateObject var router: AppRouter
    @State private var searchText: String = ""

    init(router: AppRouter) {
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        VStack(alignment: .leading) {
            TopNavBar(
                onAdd: { router.routeTo(.contactPicker) },
                onTapSettings: {},
                searchText: $searchText.animation(.easeOut(duration: .transitionFast))
            )
            FriendList(
                searchText: $searchText,
                onSelect: { friend in router.routeTo(.editFriend(friend)) },
                onRecordConnection: { friend in
                    let event = ConnectionEvent(friend: friend)
                    let repo = ModelRepository<ConnectionEvent>()
                    try? repo.upsert(event)
                }
            )
        }.padding(.horizontal, .xs)
        Spacer()
    }
}

#Preview {
    AppRouterView { router in FriendListScreen(router: router) }
        .modelContainer(Database.testInstance(with: PreviewData.friends).container)
}
