//
//  Period.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

enum Period: String, CaseIterable, Identifiable, Codable {
    case weekly
    case everyTwoWeeks
    case monthly
    case everyTwoMonths
    case everyThreeMonths
    case everySixMonths
    case annually

    var id: String { rawValue }
    var index: Int { Self.allCases.firstIndex(of: self)! }

    var label: String {
        switch self {
        case .weekly:
            "Weekly"
        case .everyTwoWeeks:
            "Every two weeks"
        case .monthly:
            "Monthly"
        case .everyTwoMonths:
            "Every two months"
        case .everyThreeMonths:
            "Every three months"
        case .everySixMonths:
            "Every six months"
        case .annually:
            "Annually"
        }
    }

    var days: Int {
        switch self {
        case .weekly:
            7
        case .everyTwoWeeks:
            14
        case .monthly:
            30
        case .everyTwoMonths:
            60
        case .everyThreeMonths:
            90
        case .everySixMonths:
            180
        case .annually:
            365
        }
    }
}

