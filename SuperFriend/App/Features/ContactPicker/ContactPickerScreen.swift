//
//  Screen.swift
//  SuperFriend
//
//  Created by Sam Garson on 12/01/2025.
//

import SwiftUI

struct ContactPickerScreen: View {
    @StateObject var viewModel: ContactPickerViewModel
    @StateObject var router: AppRouter

    init(router: AppRouter, repo: ContactDataRepository = ContactDataRepository()) {
        _router = StateObject(wrappedValue: router)
        _viewModel = StateObject(wrappedValue: ContactPickerViewModel(repo: repo))
    }

    var body: some View {
            ScrollView {
                LazyVStack(spacing: .sm) {
                    if viewModel.limitedAccess { accessWarning }
                    contactList
                    if viewModel.emptySearch { emptySearch }
                }.padding()
            }
            .searchable(text: $viewModel.searchText)
            .onAppear { UISearchBar.appearance().tintColor = .darkGray }
            .navigationTitle("Add Contact")
    }

    private var contactList: some View {
        ForEach(viewModel.contacts, id: \.identifier) { contact in
            ContactPickerRow(
                contact: contact,
                onComplete: { router.pop() }
            ).onTapGesture {
                router.routeTo(.newFriend(contact), via: .sheet)
            }
        }
    }

    private var emptySearch: some View {
        VStack(alignment: .center, spacing: .xs) {
            Image(systemName: "exclamationmark.magnifyingglass").font(.largeTitle)
            Text("No contacts matching _\(viewModel.searchText)_").multilineTextAlignment(.center)
            Button("Reset") { viewModel.searchText = "" }.buttonStyle(.naked)
        }
        .opacity(.opacityBodyText)
        .padding(.horizontal, .md)
    }

    private var accessWarning: some View {
        Box {
            Text("Some names may not appear because SuperFriend doesn't have full contact access.")
                .opacity(.opacityBodyText)
            Button("Adjust access") { viewModel.openSettings() }.buttonStyle(.naked)
        }.padding(.bottom)
    }

    private var backButton: some View {
        Button("Back", systemImage: "chevron.left") { router.pop() }
            .font(.caption)
            .buttonStyle(.naked)
    }
}

#Preview {
    @Previewable @State var router: AppRouter = .init(isPresented: .constant(.contactPicker))

    ContactPickerScreen(
        router: router,
        repo: PreviewData.contactDataRepo
    )
}
