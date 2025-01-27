//
//  AppRouterView.swift
//  SuperFriend
//
//  Created by Sam Garson on 13/01/2025.
//

import SwiftUI
import Routing

struct AppRouterView<Content: View>: View {
    let content: (AppRouter) -> Content

    init(@ViewBuilder _ content: @escaping (AppRouter) -> Content) {
        self.content = content
    }

    var body: some View {
        RoutingView(AppRoutes.self) { router in
            content(router)
        }
    }
}

#Preview {
    AppRouterView { router in FriendListScreen(router: router) }
}
