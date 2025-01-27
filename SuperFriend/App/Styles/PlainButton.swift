//
//  NakedButton.swift
//  SuperFriend
//
//  Created by Sam Garson on 13/01/2025.
//

import SwiftUI

struct NakedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.foreground)
            .bold()
    }
}

extension ButtonStyle where Self == NakedButtonStyle {
    static var naked: Self { Self() }
}
