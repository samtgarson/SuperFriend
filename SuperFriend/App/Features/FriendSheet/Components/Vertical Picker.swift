//
//  FrequencyPicker.swift
//  SuperFriend
//
//  Created by Claude Code on 25/12/2025.
//

import SwiftUI

struct VerticalSlider<T, Label: View>: View where T: Identifiable, T: Equatable {
    var options: [T]
    var label: (T) -> Label
    @Binding var selection: T
    @State var pressing = false
    @State var selectedOffset: CGFloat
    @GestureState var dragAmount = CGFloat.zero
    @State var showingPopover = false

    init(selection: Binding<T>, options: [T], label: @escaping (T) -> Label) {
        self._selection = selection
        self.label = label
        self.selectedOffset = CGFloat(options.firstIndex(of: selection.wrappedValue) ?? 0) * itemHeight
        self.options = options
    }

    var body: some View {
        Button {
            showingPopover = true
        } label: {
            label(selection)
        }.popover(isPresented: $showingPopover) {
            slider
                .padding(.vertical, .sm)
                .padding(.horizontal, .xs)
                .presentationCompactAdaptation(.popover)
        }
    }

    var itemCount: CGFloat { CGFloat(options.count) }
    let itemHeight: CGFloat = 50
    var pickerHeight: CGFloat {
        itemHeight * (itemCount - 1)
    }
    var dragOffset: CGFloat {
        return max(0, min(selectedOffset + dragAmount, pickerHeight))
    }

    var slider: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: .sm)
                .frame(width: 1.0, height: pickerHeight)
                .padding(.leading, itemHeight * 0.25)
                .padding(.top, itemHeight / 2)
            VStack(alignment: .leading, spacing: 0) {
                ForEach(options) { item in
                    HStack(spacing: .sm) {
                        RoundedRectangle(cornerRadius: .sm).frame(width: 5, height: 1)
                        label(item).fontWeight(selection == item ? .medium : .regular)
                    }.frame(height: itemHeight)
                        .onTapGesture {
                            withAnimation {
                                selection = item
                                selectedOffset = offsetForPeriod(item)
                            }
                        }
                }
            }
            .padding(.leading, itemHeight * 0.25 - 2)

            RoundedRectangle(cornerRadius: .md)
                .foregroundStyle(.gray.opacity(pressing ? 0 : 1))
                .glassEffect(.clear.interactive())
                .frame(width: itemHeight * 0.5, height: itemHeight * 0.8)
                .scaleEffect(pressing ? 1.2 : 1.0)
                .offset(y: itemHeight * 0.1 + dragOffset)
                .gesture(
                    DragGesture(minimumDistance: 0).updating($dragAmount) { value, state, _ in
                        state = value.translation.height
                    }.onChanged { _ in
                        withAnimation { pressing = true }
                    }.onEnded { action in
                        let absOffset = selectedOffset + action.translation.height
                        let selectionIndex = round(absOffset / itemHeight)
                        selection = options[max(Int(min(itemCount - 1, selectionIndex)), 0)]
                        selectedOffset = absOffset

                        withAnimation {
                            pressing = false
                            selectedOffset = offsetForPeriod(selection)
                        }
                    }
                )
        }.padding()

    }

    private func offsetForPeriod(_ item: T) -> CGFloat {
        CGFloat(options.firstIndex(of: item)!) * itemHeight
    }
}

#Preview {
    @Previewable @State var selection: Period = .monthly

    VStack(spacing: .md) {
        VerticalSlider(selection: $selection, options: Period.allCases) { period in Text(period.label) }
        Text("Selected: \(selection.label)")
    }
}
