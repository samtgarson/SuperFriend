//
//  PlaygroundScreen.swift
//  SuperFriend
//
//  Created by Claude Code
//

#if DEBUG
import SwiftUI

struct PlaygroundScreen: View {
    @StateObject var router: AppRouter
    @State private var overrideColorScheme: ColorScheme?

    init(router: AppRouter) {
        _router = StateObject(wrappedValue: router)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .md) {
                header

                Divider()

                PlaygroundTokensView()

                Divider()

                PlaygroundButtonsView()

                Divider()

                PlaygroundComponentsView()

                Divider()

                PlaygroundTypographyView()

                Divider()

                PlaygroundColorsView()
            }
            .padding(.horizontal, .sm)
            .padding(.vertical, .md)
        }
        .preferredColorScheme(overrideColorScheme)
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("UI Playground")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Design System Reference")
                    .opacity(.opacityBodyText)
            }

            Spacer()

            colorSchemeToggleButton
        }
    }

    private var colorSchemeToggleButton: some View {
        Button(action: cycleColorScheme) {
            Image(systemName: currentSchemeIcon)
                .font(.title3)
        }
        .buttonStyle(.secondary)
//        .controlSize(.small)
    }

    private func cycleColorScheme() {
        switch overrideColorScheme {
        case nil:
            overrideColorScheme = .light
        case .light:
            overrideColorScheme = .dark
        case .dark:
            overrideColorScheme = nil
        @unknown default:
            overrideColorScheme = nil
        }
    }

    private var currentSchemeIcon: String {
        switch overrideColorScheme {
        case nil:
            return "square.3.layers.3d"
        case .light:
            return "sun.max"
        case .dark:
            return "moon"
        @unknown default:
            return "gearshape"
        }
    }
}

#Preview {
    let router = AppRouter(isPresented: .constant(.none))
    PlaygroundScreen(router: router)
}
#endif
