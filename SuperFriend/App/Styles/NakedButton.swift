//
//  NakedButton.swift
//  SuperFriend
//
//  Created by Sam Garson on 13/01/2025.
//

import SwiftUI

struct NakedButtonStyle: ButtonStyle {
    @Environment(\.buttonIsLoading) var isLoading
    @Environment(\.colorScheme) var colorScheme

    @State private var showLoading: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: .xs) {
            if showLoading { ProgressView().controlSize(.mini) }
            configuration.label
                .foregroundStyle(color(for: configuration))
                .opacity(showLoading ? .opacitySlightlyFaded : 1)
        }
        .onChange(of: isLoading, initial: true) {
            withAnimation(.easeOut(duration: 0.1)) { showLoading = isLoading }
        }
    }

    private func color(for config: Configuration) -> Color {
        if config.role == .destructive {
            return .red
        }

        switch colorScheme {
        case .dark:
            return .white
        default:
            return .black
        }
    }
}

extension ButtonStyle where Self == NakedButtonStyle {
    static var naked: Self { Self() }
}

#Preview {
    @Previewable @State var isLoading: Bool = false
    VStack(alignment: .center, spacing: .sm) {
        Button("Tap me", action: { isLoading.toggle() })
            .with(loading: isLoading)
            .buttonStyle(.naked)

        Button("Tap me", role: .destructive, action: { isLoading.toggle() })
            .with(loading: isLoading)
            .buttonStyle(.naked)
    }
}
