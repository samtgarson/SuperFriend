//
//  FrequencyPicker.swift
//  SuperFriend
//
//  Created by Claude Code on 25/12/2025.
//

import SwiftUI

struct FrequencyPicker: View {
    @Binding var selection: Period

    var body: some View {

        Menu {
            Picker("How often will you keep in touch?", selection: $selection) {
                ForEach(Period.allCases) { period in
                    Text(period.label).tag(period)
                }
            }
        } label: {
            Label(selection.label, systemImage: "calendar.and.person")
        }

    }
}

#Preview {
    @Previewable @State var selection: Period = .monthly

    VStack(spacing: .md) {
        FrequencyPicker(selection: $selection)
        Text("Selected: \(selection.label)")
    }
}
