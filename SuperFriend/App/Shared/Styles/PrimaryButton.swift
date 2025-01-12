//
//  PrimaryButton.swift
//  SuperFriend
//
//  Created by Sam Garson on 11/01/2025.
//

import SwiftUI
import LucideIcons

struct PrimaryButtonStyle: ButtonStyle {
    var style: RoundedStyle = .filled
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.buttonIsLoading) var isLoading
    @Environment(\.buttonIcon) var icon

    @State private var showLoading: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 10) {
            if showLoading { ProgressView().controlSize(.small) } else
            if let icon = icon { Image(systemName: icon) }
            configuration.label
        }
        .rounded(style)
        .opacity(opacity(isPressed: configuration.isPressed))
        .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
        .onChange(of: isLoading, initial: true) {
            withAnimation(.easeOut(duration: 0.1)) { showLoading = isLoading }
        }
    }

    private func opacity(isPressed: Bool) -> CGFloat {
        guard isEnabled && !showLoading else {
            return 0.5
        }

        return isPressed ? 0.7 : 1
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self { Self() }
    static var secondary: Self { Self(style: .outlined) }
}

#Preview {
    struct PreviewWrapper: View {
        @State var loading: Bool = true

        var body: some View {
            VStack(spacing: 16) {
                Button(action: { loading.toggle() }, label: {
                    Text("Press Me")
                }).buttonStyle(.primary)

                Button(action: {}, label: {
                    Text("Loading")
                })
                .with(loading: loading)
                .buttonStyle(.primary)

                Button(action: {}, label: {
                    Text("Disabled")
                })
                .buttonStyle(.primary)
                .disabled(true)

                Button(action: {}, label: {
                    Text("Icon")
                })
                .with(icon: "plus", loading: !loading)
                .buttonStyle(.primary)

                Button("Outlined") {}
                    .with(icon: "gearshape")
                    .buttonStyle(.secondary)

                Button(action: {}, label: {
                    Text("Small")
                })
                .controlSize(.small)
                .buttonStyle(.primary)

            }.frame(width: 300, height: 500)
        }
    }

    return PreviewWrapper()
}
