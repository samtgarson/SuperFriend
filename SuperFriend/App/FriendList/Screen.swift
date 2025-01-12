//
//  Screen.swift
//  SuperFriend
//
//  Created by Sam Garson on 12/01/2025.
//

import SwiftUI

struct FriendListScreen: View {
    var body: some View {
        VStack(alignment: .leading) {
            TopNavBar(onAdd: {}, onTapSettings: {})
        }
        Spacer()
    }
}

#Preview {
    FriendListScreen()
}
