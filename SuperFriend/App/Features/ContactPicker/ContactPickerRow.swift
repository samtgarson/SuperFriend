//
//  ContactPickerRow.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

import SwiftUI

struct ContactPickerRow: View {
    var contact: ContactData
    var onComplete: () -> Void

    var body: some View {
        HStack(spacing: .xs) {
            Avatar(
                imageData: contact.imageData,
                givenName: contact.givenName,
                familyName: contact.familyName,
                size: .buttonHeight
            )
            VStack(alignment: .leading) {
                Text("\(contact.givenName) \(contact.familyName)").bold()
                if !contact.organizationName.isEmpty {
                    Text(contact.organizationName).opacity(.opacitySlightlyFaded)
                }
            }
            Spacer()
            Image(systemName: "plus")
        }.foregroundStyle(.foreground)
    }
}

 #Preview {
     ContactPickerRow(
        contact: PreviewData.contactData.first!,
        onComplete: { print("completed")
        }
    )
 }
