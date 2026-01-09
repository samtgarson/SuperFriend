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

struct ButtonIsLoadingEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

struct ButtonWideEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    public var buttonIcon: String? {
        get { self[ButtonIconEnvironmentKey.self] }
        set { self[ButtonIconEnvironmentKey.self] = newValue }
    }

    public var buttonIsLoading: Bool {
        get { self[ButtonIsLoadingEnvironmentKey.self] }
        set { self[ButtonIsLoadingEnvironmentKey.self] = newValue }
    }

    public var buttonIsWide: Bool {
        get { self[ButtonWideEnvironmentKey.self] }
        set { self[ButtonWideEnvironmentKey.self] = newValue }
    }
}

struct ButtonModifier: ViewModifier {
    var icon: String?
    var loading: Bool = false
    var wide: Bool = false

    func body(content: Content) -> some View {
        content
            .environment(\.buttonIcon, icon)
            .environment(\.buttonIsLoading, loading)
            .environment(\.buttonIsWide, wide)
    }
}

extension Button {
    func with(icon: String? = nil, loading: Bool = false, wide: Bool = false) -> some View {
        modifier(ButtonModifier(icon: icon, loading: loading, wide: wide))
    }
}
