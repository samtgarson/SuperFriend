//
//  CalendarExtensions.swift
//  SuperFriend
//
//  Created by Sam Garson on 20/01/2025.
//

import Foundation

extension Calendar {
    func numberOfDays(between start: Date, and end: Date) -> Int {
        let fromDate = startOfDay(for: start)
        let toDate = startOfDay(for: end)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)

        return numberOfDays.day!
    }
}
