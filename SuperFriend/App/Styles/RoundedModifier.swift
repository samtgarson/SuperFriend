//
//  RoundedModifier.swift
//  SuperFriend
//
//  Created by Sam Garson on 11/01/2025.
//

import SwiftUI

enum RoundedStyle {
    case filled
    case outlined
}

struct RoundedModifier: ViewModifier {
    var style: RoundedStyle

    @Environment(\.controlSize) var controlSize

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, paddingX)
            .frame(height: height)
            .background(backgroundView)
    }

    private var paddingX: CGFloat {
        switch controlSize {
        case .small:
            10
        default:
            16
        }
    }

    private var height: CGFloat {
        switch controlSize {
        case .small:
            .buttonHeightSmall
        default:
            .buttonHeight
        }
    }

    private var backgroundView: some View {
        Group {
            switch style {
            case .filled:
                Capsule().fill(.foreground.opacity(.opacityVeryFaded))
            case .outlined:
                Capsule().fill(.clear).stroke(.foreground.opacity(.opacityFaded), lineWidth: 1)
            }
        }
    }
}

extension View {
    func rounded(_ style: RoundedStyle = .filled) -> some View {
        modifier(RoundedModifier(style: style))
    }
}
