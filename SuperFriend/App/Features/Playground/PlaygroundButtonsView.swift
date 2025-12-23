//
//  PlaygroundButtonsView.swift
//  SuperFriend
//
//  Created by Claude Code
//

#if DEBUG
import SwiftUI

struct PlaygroundButtonsView: View {
    var body: some View {
        PlaygroundSection("Button Styles") {
            VStack(alignment: .leading, spacing: .md) {
                primaryButtons
                Divider()
                secondaryButtons
                Divider()
                nakedButtons
            }
        }
    }

    private var primaryButtons: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Primary (.primary) - Filled")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: .xs) {
                HStack {
                    Button("Default") {}
                        .buttonStyle(.primary)

                    Button("With Icon") {}
                        .with(icon: "plus")
                        .buttonStyle(.primary)
                }

                HStack {
                    Button("Loading") {}
                        .with(loading: true)
                        .buttonStyle(.primary)

                    Button("Disabled") {}
                        .buttonStyle(.primary)
                        .disabled(true)
                }

                HStack {
                    Button("Small") {}
                        .buttonStyle(.primary)
                        .controlSize(.small)

                    Button("Small + Icon") {}
                        .with(icon: "checkmark")
                        .buttonStyle(.primary)
                        .controlSize(.small)
                }
            }
        }
    }

    private var secondaryButtons: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Secondary (.secondary) - Outlined")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: .xs) {
                HStack {
                    Button("Default") {}
                        .buttonStyle(.secondary)

                    Button("With Icon") {}
                        .with(icon: "gearshape")
                        .buttonStyle(.secondary)
                }

                HStack {
                    Button("Loading") {}
                        .with(loading: true)
                        .buttonStyle(.secondary)

                    Button("Disabled") {}
                        .buttonStyle(.secondary)
                        .disabled(true)
                }

                HStack {
                    Button("Small") {}
                        .buttonStyle(.secondary)
                        .controlSize(.small)

                    Button("Small + Icon") {}
                        .with(icon: "xmark")
                        .buttonStyle(.secondary)
                        .controlSize(.small)
                }
            }
        }
    }

    private var nakedButtons: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Naked (.naked) - Text Only")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: .xs) {
                HStack {
                    Button("Default") {}
                        .buttonStyle(.naked)

                    Button("Loading") {}
                        .with(loading: true)
                        .buttonStyle(.naked)
                }

                HStack {
                    Button("Disabled") {}
                        .buttonStyle(.naked)
                        .disabled(true)

                    Button("Destructive", role: .destructive) {}
                        .buttonStyle(.naked)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        PlaygroundButtonsView()
            .padding(.sm)
    }
}
#endif
