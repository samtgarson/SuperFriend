//
//  Screen.swift
//  SuperFriend
//
//  Created by Sam Garson on 12/01/2025.
//

import SwiftUI

struct FriendListScreen: View {
    var navigation: AppNavigation
    @State private var searchText: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            TopNavBar(
                onAdd: { navigation.path.append(.contactPicker) },
                onTapSettings: { navigation.path.append(.settings) },
                onSecretGesture: {
                    #if DEBUG
                        navigation.path.append(.playground)
                    #endif
                },
                searchText: $searchText.animation(.easeOut(duration: .transitionFast))
            )
            FriendList(
                searchText: $searchText,
                onSelect: { friend in
                    navigation.activeSheet = .friendFlow(friend: friend)
                },
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
    let navigation = AppNavigation()
    NavigationStack(path: .constant(.init())) {
        FriendListScreen(navigation: navigation)
    }
    .modelContainer(Database.testInstance(with: PreviewData.friends).container)
}
