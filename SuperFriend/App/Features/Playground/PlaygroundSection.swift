//
//  PlaygroundSection.swift
//  SuperFriend
//
//  Created by Claude Code
//

#if DEBUG
import SwiftUI

struct PlaygroundSection<Content: View>: View {
    let title: String
    let content: () -> Content

    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)

            content()
        }
    }
}

#Preview {
    PlaygroundSection("Sample Section") {
        Text("Section content goes here")
            .opacity(.opacityBodyText)
    }
    .padding(.sm)
}
#endif
