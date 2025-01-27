//
//  Box.swift
//  SuperFriend
//
//  Created by Sam Garson on 13/01/2025.
//

import SwiftUI

struct Box<Content: View>: View {
    var style: RoundedStyle = .filled
    let content: Content

    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .xs) {
            content.frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.sm)
        .background(backgroundView)
    }

    private var backgroundView: some View {
        Group {
            switch style {
            case .filled:
                RoundedRectangle(cornerRadius: .cornerRadiusSmall).fill(.foreground.opacity(.opacityVeryFaded))
            case .outlined:
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(.background).stroke(.foreground.opacity(.opacityFaded), lineWidth: 1)
            }
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: .sm) {
        Button("Click Here") {}.buttonStyle(.secondary)
        Box {
            Text("Title").fontWeight(.semibold)
            Text("""
Planning: Session where the sprint is built. All tickets that come into the sprint should be groomed beforehand \
and be aligned to the goals of the sprint. This session should ideally not take more than 30 mins.
""").opacity(.opacityBodyText)
        }

        Box {
            Text("Foo bar")
        }
    }.padding()
}
