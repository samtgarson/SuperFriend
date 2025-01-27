//
//  ButtonModifier.swift
//  SuperFriend
//
//  Created by Sam Garson on 11/01/2025.
//

import Foundation
import SwiftUI

// MARK:

struct ButtonIconEnvironmentKey: EnvironmentKey {
    static var defaultValue: String?
}

struct ButtonIsloadingEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    public var buttonIcon: String? {
        get { self[ButtonIconEnvironmentKey.self] }
        set { self[ButtonIconEnvironmentKey.self] = newValue }
    }

    public var buttonIsLoading: Bool {
        get { self[ButtonIsloadingEnvironmentKey.self] }
        set { self[ButtonIsloadingEnvironmentKey.self] = newValue }
    }
}

struct ButtonModifier: ViewModifier {
    var icon: String?
    var loading: Bool = false

    func body(content: Content) -> some View {
        content
            .environment(\.buttonIcon, icon)
            .environment(\.buttonIsLoading, loading)
    }
}

extension Button {
    func with(icon: String? = nil, loading: Bool = false) -> some View {
        modifier(ButtonModifier(icon: icon, loading: loading))
    }
}
