//
//  SettingsScreen.swift
//  SuperFriend
//
//  Created by Claude Code on 23/01/2025.
//

import SwiftUI

struct SettingsScreen: View {
    var navigation: AppNavigation

    var body: some View {
        VStack(spacing: .md) {
            Text("Settings")
                .font(.title)
            Text("Coming soon...")
                .opacity(.opacityBodyText)
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    let navigation = AppNavigation()
    NavigationStack {
        SettingsScreen(navigation: navigation)
    }
}
