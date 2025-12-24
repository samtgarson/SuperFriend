//
//  AsyncButtonModifier.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

import Foundation
import SwiftUI

extension Button {
    public init(action: @escaping () async -> Void, @ViewBuilder label: () -> Label) {
        self.init(action: {
            Task { await action() }
        }, label: label)
    }

    public init(role: ButtonRole, action: @escaping () async -> Void, @ViewBuilder label: () -> Label) {
        self.init(role: role, action: {
            Task { await action() }
        }, label: label)
    }
}

struct AsyncButton<Label>: View where Label: View {
    @State var loading = false
    var label: Label
    var action: () async throws -> Void
    var role: ButtonRole?

    public init(action: @escaping () async throws -> Void, @ViewBuilder label: () -> Label, role: ButtonRole? = nil) {
        self.label = label()
        self.action = action
        self.role = role
    }

    var body: some View {
        if let role = role {
            Button(role: role, action: asyncAction, label: { label })
                .with(loading: loading)
        } else {
            Button(action: asyncAction, label: { label })
                .with(loading: loading)
        }
    }

    private func asyncAction() async {
        self.loading = true
        try? await action()
        self.loading = false
    }
}

#Preview {
    VStack {
        AsyncButton(action: {
            try? await Task.sleep(nanoseconds: 1000000000)
        }, label: {
            Text("Sleep")
        }).buttonStyle(.primary)

        AsyncButton(action: {
            try? await Task.sleep(nanoseconds: 1000000000)
        }, label: {
            Text("Sleep")
        }, role: .destructive).buttonStyle(.naked)
    }.padding()
}
