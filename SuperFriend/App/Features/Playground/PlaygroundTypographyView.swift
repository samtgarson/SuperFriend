//
//  PlaygroundTypographyView.swift
//  SuperFriend
//
//  Created by Claude Code
//

#if DEBUG
import SwiftUI

struct PlaygroundTypographyView: View {
    var body: some View {
        PlaygroundSection("Typography") {
            VStack(alignment: .leading, spacing: .md) {
                fontSizes
                Divider()
                fontWeights
                Divider()
                opacityVariations
            }
        }
    }

    private var fontSizes: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Font Sizes")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: 4) {
                Text("Large Title")
                    .font(.largeTitle)

                Text("Title")
                    .font(.title)

                Text("Title 2")
                    .font(.title2)

                Text("Title 3")
                    .font(.title3)

                Text("Headline")
                    .font(.headline)

                Text("Body (Default)")
                    .font(.body)

                Text("Caption")
                    .font(.caption)
            }
        }
    }

    private var fontWeights: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Font Weights")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: 4) {
                Text("Regular Weight")
                    .fontWeight(.regular)

                Text("Semibold Weight")
                    .fontWeight(.semibold)

                Text("Bold Weight")
                    .fontWeight(.bold)
            }
        }
    }

    private var opacityVariations: some View {
        VStack(alignment: .leading, spacing: .sm) {
            Text("Text Opacity Variations")
                .fontWeight(.semibold)
                .opacity(.opacityBodyText)

            VStack(alignment: .leading, spacing: 4) {
                Text("Full opacity (1.0)")
                    .opacity(1.0)

                Text("Body text opacity (0.8)")
                    .opacity(.opacityBodyText)

                Text("Slightly faded opacity (0.65)")
                    .opacity(.opacitySlightlyFaded)

                Text("Faded opacity (0.2)")
                    .opacity(.opacityFaded)

                Text("Very faded opacity (0.05)")
                    .opacity(.opacityVeryFaded)
            }
        }
    }
}

#Preview {
    ScrollView {
        PlaygroundTypographyView()
            .padding(.sm)
    }
}
#endif
