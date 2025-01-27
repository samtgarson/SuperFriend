//
//  Avatar.swift
//  SuperFriend
//
//  Created by Sam Garson on 14/01/2025.
//

import SwiftUI
import Contacts

struct Avatar: View {
    var imageData: Data?
    var givenName: String?
    var familyName: String?
    var size: CGFloat = .md

    init(imageData: Data? = nil, givenName: String? = nil, familyName: String? = nil, size: CGFloat? = nil) {
        self.imageData = imageData
        self.givenName = givenName
        self.familyName = familyName
        if let size = size { self.size = size }
    }

    init(from contact: ContactData? = nil, size: CGFloat? = nil) {
        self.imageData = contact?.imageData
        self.givenName = contact?.givenName
        self.familyName = contact?.familyName
        if let size = size { self.size = size }
    }

    var body: some View {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle().frame(width: size, height: size).opacity(.opacityVeryFaded)
                if let initials = initials {
                    Text(initials)
                        .font(.system(size: size * 0.4))
                        .foregroundStyle(.foreground)
                        .opacity(.opacityBodyText)
                } else {
                    Image(systemName: "questionmark")
                        .font(.system(size: size * 0.4))
                        .opacity(.opacitySlightlyFaded)
                }
            }
        }
    }

    private var initials: String? {
        guard let given = givenName?.first, let family = familyName?.first else { return nil }
        return "\(given)\(family)"
    }
}

#Preview {
    @Previewable @State var size: CGFloat = .md
    VStack(spacing: .sm) {
        Spacer()
        Avatar(
            imageData: UIImage(systemName: "plus.circle.fill")?.pngData(),
            givenName: "Sam",
            familyName: "Garson",
            size: size
        )
        Avatar(givenName: "Sam", familyName: "Garson", size: size)
        Avatar(givenName: "", familyName: "", size: size)
        Spacer()
        Text("Size: \(size.formatted())")
        Slider(value: $size, in: .xs...100, step: 5)
    }.padding()
}
