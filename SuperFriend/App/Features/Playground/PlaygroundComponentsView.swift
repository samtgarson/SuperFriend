//
//  PlaygroundComponentsView.swift
//  SuperFriend
//
//  Created by Claude Code
//

#if DEBUG
import SwiftUI

struct PlaygroundComponentsView: View {
    var body: some View {
        PlaygroundSection("Components") {
            VStack(alignment: .leading, spacing: .md) {
                boxComponents
                Divider()
                avatarComponents
                Divider()
                swipeIconComponents
            }
        }
    }

    private var boxComponents: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Box Component")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: .xs) {
                Box {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Box Container")
                            .fontWeight(.semibold)
                        Text("Grouped content with padding and background")
                            .font(.caption)
                            .opacity(.opacityBodyText)
                    }
                }

                Box {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Another Example")
                            .fontWeight(.semibold)
                        Text("Used for cards and content grouping")
                            .font(.caption)
                            .opacity(.opacityBodyText)
                    }
                }
            }
        }
    }

    private var avatarComponents: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Avatar Component")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: .xs) {
                HStack(spacing: .sm) {
                    VStack(spacing: 4) {
                        Avatar(imageData: nil, givenName: "Sam", familyName: "Garson", size: 24)
                        Text("Small (24)")
                            .font(.caption)
                            .opacity(.opacityBodyText)
                    }

                    VStack(spacing: 4) {
                        Avatar(imageData: nil, givenName: "Sam", familyName: "Garson", size: .md)
                        Text("Default (40)")
                            .font(.caption)
                            .opacity(.opacityBodyText)
                    }

                    VStack(spacing: 4) {
                        Avatar(imageData: nil, givenName: "Sam", familyName: "Garson", size: 60)
                        Text("Large (60)")
                            .font(.caption)
                            .opacity(.opacityBodyText)
                    }
                }

                HStack(spacing: .sm) {
                    VStack(spacing: 4) {
                        Avatar(imageData: nil, givenName: "Jane", familyName: "Doe", size: .md)
                        Text("With initials")
                            .font(.caption)
                            .opacity(.opacityBodyText)
                    }

                    VStack(spacing: 4) {
                        Avatar(imageData: nil, givenName: nil, familyName: nil, size: .md)
                        Text("No name")
                            .font(.caption)
                            .opacity(.opacityBodyText)
                    }
                }
            }
        }
    }

    private var swipeIconComponents: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("SwipeIcon Component")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            HStack(spacing: .sm) {
                SwipeIcon(systemName: "checkmark")
                SwipeIcon(systemName: "xmark")
                SwipeIcon(systemName: "trash")
                SwipeIcon(systemName: "pencil")
                SwipeIcon(systemName: "star.fill")
            }
            .font(.title2)
        }
    }
}

#Preview {
    ScrollView {
        PlaygroundComponentsView()
            .padding(.sm)
    }
}
#endif
