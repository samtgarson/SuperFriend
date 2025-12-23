//
//  PlaygroundColorsView.swift
//  SuperFriend
//
//  Created by Claude Code
//

#if DEBUG
import SwiftUI

struct PlaygroundColorsView: View {
    var body: some View {
        PlaygroundSection("Colors") {
            VStack(alignment: .leading, spacing: .md) {
                semanticColors
                Divider()
                systemColors
            }
        }
    }

    private var semanticColors: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Semantic Colors")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: .xs) {
                colorRow(color: .primary, name: "primary")
                colorRow(color: .secondary, name: "secondary")
                colorRow(color: .gray, name: "gray")
            }
        }
    }

    private var systemColors: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("System Colors")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: .xs) {
                colorRow(color: .red, name: "red")
                colorRow(color: .orange, name: "orange")
                colorRow(color: .yellow, name: "yellow")
                colorRow(color: .green, name: "green")
                colorRow(color: .blue, name: "blue")
                colorRow(color: .purple, name: "purple")
                colorRow(color: .pink, name: "pink")
            }
        }
    }

    private func colorRow(color: Color, name: String) -> some View {
        HStack(spacing: .sm) {
            Circle()
                .fill(color)
                .frame(width: 30, height: 30)
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(.opacityFaded), lineWidth: 1)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.caption)
                    .fontWeight(.semibold)

                HStack(spacing: 4) {
                    Circle()
                        .fill(color.opacity(.opacityVeryFaded))
                        .frame(width: 16, height: 16)

                    Circle()
                        .fill(color.opacity(.opacityFaded))
                        .frame(width: 16, height: 16)

                    Circle()
                        .fill(color.opacity(.opacitySlightlyFaded))
                        .frame(width: 16, height: 16)

                    Circle()
                        .fill(color.opacity(.opacityBodyText))
                        .frame(width: 16, height: 16)

                    Circle()
                        .fill(color)
                        .frame(width: 16, height: 16)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        PlaygroundColorsView()
            .padding(.sm)
    }
}
#endif
