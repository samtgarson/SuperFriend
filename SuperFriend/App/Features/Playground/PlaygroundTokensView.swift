//
//  PlaygroundTokensView.swift
//  SuperFriend
//
//  Created by Claude Code
//

#if DEBUG
import SwiftUI

struct PlaygroundTokensView: View {
    var body: some View {
        PlaygroundSection("Design Tokens") {
            VStack(alignment: .leading, spacing: .md) {
                spacingTokens
                Divider()
                cornerRadiiTokens
                Divider()
                durationTokens
                Divider()
                opacityTokens
            }
        }
    }

    private var spacingTokens: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Spacing")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            HStack(alignment: .bottom, spacing: .sm) {
                tokenBox(value: .xs, label: "xs (10)")
                tokenBox(value: .sm, label: "sm (22)")
                tokenBox(value: .md, label: "md (40)")
            }
        }
    }

    private func tokenBox(value: CGFloat, label: String) -> some View {
        VStack(spacing: 4) {
            Rectangle()
                .fill(.foreground.opacity(.opacityFaded))
                .frame(width: value, height: value)

            Text(label)
                .font(.caption)
                .opacity(.opacityBodyText)
        }
    }

    private var cornerRadiiTokens: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Corner Radii")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: .xs) {
                HStack {
                    RoundedRectangle(cornerRadius: .cornerRadiusSmall)
                        .fill(.foreground.opacity(.opacityFaded))
                        .frame(width: 60, height: 40)

                    Text("cornerRadiusSmall (14)")
                        .font(.caption)
                        .opacity(.opacityBodyText)
                }

                HStack {
                    RoundedRectangle(cornerRadius: .cornerRadius)
                        .fill(.foreground.opacity(.opacityFaded))
                        .frame(width: 60, height: 40)

                    Text("cornerRadius (22)")
                        .font(.caption)
                        .opacity(.opacityBodyText)
                }
            }
        }
    }

    private var durationTokens: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Animation Durations")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: 4) {
                Text("transitionFast: 0.1s")
                    .font(.caption)
                    .opacity(.opacityBodyText)

                Text("transition: 0.25s")
                    .font(.caption)
                    .opacity(.opacityBodyText)
            }
        }
    }

    private var opacityTokens: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Opacity Values")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: 4) {
                opacityRow(value: .opacityVeryFaded, label: "opacityVeryFaded (0.05)")
                opacityRow(value: .opacityFaded, label: "opacityFaded (0.2)")
                opacityRow(value: .opacitySlightlyFaded, label: "opacitySlightlyFaded (0.65)")
                opacityRow(value: .opacityBodyText, label: "opacityBodyText (0.8)")
                opacityRow(value: 1.0, label: "full opacity (1.0)")
            }
        }
    }

    private func opacityRow(value: Double, label: String) -> some View {
        HStack(spacing: .xs) {
            Circle()
                .fill(.foreground.opacity(value))
                .frame(width: 20, height: 20)

            Text(label)
                .font(.caption)
                .opacity(.opacityBodyText)
        }
    }
}

#Preview {
    ScrollView {
        PlaygroundTokensView()
            .padding(.sm)
    }
}
#endif
