//
//  FriendSheetRouter.swift
//  SuperFriend
//
//  Created by Sam Garson on 24/12/2025.
//

import SwiftUI

protocol FriendSheetAppNavigation {
    func dismissSheet()
}

struct FriendSheetRouter: View {
    @StateObject var viewModel: FriendSheetRouterViewModel
    var friend: Friend
    var navigation: FriendSheetAppNavigation

    init(
        friend: Friend,
        navigator: FriendSheetAppNavigation,
        repo: ModelRepository<Friend> = .init()
    ) {
        _viewModel = StateObject(wrappedValue: FriendSheetRouterViewModel(friend: friend, friendRepo: repo))
        self.navigation = navigator
        self.friend = friend
    }

    var body: some View {
        if let contactData = friend.contact {
            // Existing friend: Show details with navigation to edit
            NavigationStack(path: $viewModel.path) {
                FriendDetailsScreen(
                    friend: friend,
                    contact: contactData,
                    onAction: { action in
                        switch action {
                        case .edit:
                            viewModel.path.append(.edit)
                        case .done:
                            navigation.dismissSheet()
                        case .remove:
                            try? viewModel.destroy()
                        default:
                            print(action)
                        }
                    }
                )
                .navigationDestination(for: FriendSheetRouterViewModel.Path.self) { pathCase in
                    switch pathCase {
                    case .edit:
                        EditContactScreen(
                            friend: friend,
                            contact: contactData,
                            onComplete: { viewModel.path.removeLast() }
                        )
                    }
                }
            }
        } else {
            Text("Oops")
        }

    }
}

#Preview {
    FriendSheetRouter(
        friend: PreviewData.friends.first!,
        navigator: AppNavigation(),
        repo: ModelRepository(with: PreviewData.databaseInstance.container)
    )
}
