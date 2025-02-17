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
    @Binding var searchText: String
    @FocusState private var searchFocused: Bool
    @State var showSearch = false

    var body: some View {
        HStack(spacing: .xs) {
            if !showSearch { addButton }
            search
            if !showSearch { settingsButton }
        }
        .padding(.vertical, .xs)
        .onChange(of: searchFocused, initial: false) {
            withAnimation(.easeOut(duration: .transition)) { showSearch = searchFocused }
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
            Image(systemName: "magnifyingglass").opacity(showSearch ? 1 : .opacityFaded)
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
    @Previewable @State var searchText: String = ""

    VStack {
        TopNavBar(
            onAdd: { debugPrint("Tapped add") },
            onTapSettings: { debugPrint("Tapped settings") },
            searchText: $searchText
        )
        Divider()
        Spacer()
    }

}
