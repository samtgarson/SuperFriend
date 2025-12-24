//
//  Screen.swift
//  SuperFriend
//
//  Created by Sam Garson on 12/01/2025.
//

import SwiftUI

struct ContactPickerScreen: View {
    @StateObject var viewModel: ContactPickerViewModel
    var navigation: AppNavigation

    init(navigation: AppNavigation, repo: ContactDataRepository = ContactDataRepository()) {
        self.navigation = navigation
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
                onComplete: { navigation.path.removeLast() }
            ).onTapGesture {
                navigation.activeSheet = .newFriend(contactData: contact)
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
}

#Preview {
    let navigation = AppNavigation()
    NavigationStack(path: .constant([AppNavigation.Path.contactPicker])) {
        ContactPickerScreen(
            navigation: navigation,
            repo: PreviewData.contactDataRepo
        )
    }
}
