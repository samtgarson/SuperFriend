//
//  TopNavBar.swift
//  SuperFriend
//
//  Created by Sam Garson on 11/01/2025.
//

import SwiftUI

struct TopNavBar: View {
    var onAdd: () -> Void
    var onTapSettings: () -> Void
    @State var searchText = ""
    @FocusState private var searchFocused: Bool
    @State var showSearch = false

    var body: some View {
        HStack(spacing: 12) {
            if !showSearch { addButton }
            search
            if !showSearch { settingsButton }
        }
        .padding()
        .onChange(of: searchFocused, initial: false) {
            withAnimation(.easeOut(duration: 0.2)) { showSearch = searchFocused }
        }
    }

    private var addButton: some View {
        Button(action: onAdd, label: { Image(systemName: "plus") })
            .buttonStyle(.primary)
            .transition(AnyTransition.opacity.combined(with: .move(edge: .leading)))
    }

    private var settingsButton: some View {
        Button(action: onTapSettings, label: {
            Image(systemName: "gearshape")
        }).buttonStyle(.secondary)
            .transition(AnyTransition.opacity.combined(with: .move(edge: .trailing)))
    }

    private var search: some View {
        HStack {
            Image(systemName: "magnifyingglass").opacity(showSearch ? 1 : 0.3)
            ZStack(alignment: .leading) {
                TextField(text: $searchText, label: { Text("Search") })
                    .focused($searchFocused)
            }
            if searchFocused {
                Button(action: { searchFocused = false }, label: {
                    Image(systemName: "xmark.circle.fill")
                })
                .foregroundStyle(.secondary)
                .transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .rounded(.outlined)
        .onTapGesture { searchFocused = true }
    }
}

#Preview {
    TopNavBar(
        onAdd: { debugPrint("Tapped add") },
        onTapSettings: { debugPrint("Tapped settings") }
    )
}
