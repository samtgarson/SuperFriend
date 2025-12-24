//
//  FriendSheetRouterViewModel.swift
//  SuperFriend
//
//  Created by Sam Garson on 24/12/2025.
//

import SwiftUI
import SwiftNavigation

public class FriendSheetRouterViewModel: ObservableObject {
    var friend: Friend
    @Published var path: [Path] = []
    private var repo: ModelRepository<Friend>

    init(friend: Friend, friendRepo: ModelRepository<Friend> = ModelRepository()) {
        self.friend = friend
        self.repo = friendRepo
    }

    @CasePathable
    enum Path: Hashable {
        case edit
    }

    @MainActor func destroy() throws {
        try repo.delete(friend)
    }
}
