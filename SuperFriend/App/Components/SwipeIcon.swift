//
//  SwipeIcon.swift
//  SuperFriend
//
//  Created by Sam Garson on 18/01/2025.
//

import SwiftUI

struct SwipeIcon: View {
    var systemName: String

    var body: some View {
        if let uiImage = UIImage(systemName: systemName) {
            Image(
                uiImage: uiImage
                    .withTintColor(.label, renderingMode: .alwaysOriginal)
            )
        }
    }
}

#Preview {
    SwipeIcon(systemName: "hand.wave.fill")
}
