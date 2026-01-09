//
//  Spacing.swift
//  SuperFriend
//
//  Created by Sam Garson on 12/01/2025.
//

import SwiftUI

// swiftlint:disable identifier_name
extension CGFloat {
    // MARK: Spacing
    static var xs: CGFloat = 10
    static var sm: CGFloat = 22
    static var md: CGFloat = 40

    // MARK: Corner Radii
    static var cornerRadiusSmall: CGFloat = 14
    static var cornerRadius: CGFloat = 22

    // MARK: Buttons
    static var buttonHeightSmall: CGFloat = .cornerRadiusSmall * 2
    static var buttonHeight: CGFloat = .cornerRadius * 2
}

extension Double {
    // MARK: Durations
    static var transitionFast: Double = 0.1
    static var transition: Double = 0.25

    // MARK: Opacities
    static var opacityFaded: Double = 0.2
    static var opacitySlightlyFaded: Double = 0.65
    static var opacityVeryFaded: Double = 0.1
    static var opacityBodyText: Double = 0.8
}

extension Date {
    static var yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    static var lastWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!
}
// swiftlint:enable identifier_name
