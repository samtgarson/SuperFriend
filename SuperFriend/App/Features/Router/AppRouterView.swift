//
//  AppRouterView.swift
//  SuperFriend
//
//  Created by Sam Garson on 13/01/2025.
//

import SwiftUI
import Routing

struct AppRouterView: View {
    @StateObject var router: AppRouter = .init(isPresented: .constant(.none))

    var body: some View {
        RoutingView(router) { router in
            router.start(.friendList)
        }
    }
}

#Preview {
    AppRouterView()
        .modelContainer(PreviewData.databaseInstance.container)
}
