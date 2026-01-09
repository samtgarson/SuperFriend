//
//  FriendProfile.swift
//  SuperFriend
//
//  Created by Sam Garson on 26/12/2025.
//
import SwiftUI

struct FriendProfile: View {
    var contact: ContactData
    @Binding var period: Period

    var body: some View {
        HStack(spacing: .sm) {
            Avatar(from: contact, size: 120)

            VStack(alignment: .leading, spacing: .xs) {
                Text(contact.fullName)
                    .bold()
                    .font(.title3)
                if !contact.organizationName.isEmpty {
                    Text(contact.organizationName)
                        .opacity(.opacityBodyText)
                }
                FrequencyPicker(selection: $period)
                    .padding(.top, .xs)
            }

            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var period: Period = .weekly
    FriendProfile(contact: PreviewData.contactData[0], period: $period)
}
