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
                onAdd: { router.routeTo(.contactPicker, via: .push) },
                onTapSettings: {},
                onSecretGesture: {
                    #if DEBUG
                    router.routeTo(.playground, via: .push)
                    #endif
                },
                searchText: $searchText.animation(.easeOut(duration: .transitionFast))
            )
            FriendList(
                searchText: $searchText,
                onSelect: { friend in router.routeTo(.editFriend(friend), via: .sheet) },
                onRecordConnection: { friend in
                    let event = ConnectionEvent(friend: friend)
                    let repo = ModelRepository<ConnectionEvent>()
                    try? repo.upsert(event)
                }
            )
        }
        .padding(.horizontal, .xs)
        Spacer()
    }
}

#Preview {
    AppRouterView()
        .modelContainer(Database.testInstance(with: PreviewData.friends).container)
}
