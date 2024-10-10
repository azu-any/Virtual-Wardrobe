//
//  Date.swift
//  Virtual Wardrobe
//
//  Created by Azuany Mila Cerón on 09/10/24.
//

import Foundation

extension Date {
    
    var startOfTheDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var isToday: Bool {
        isSameDay(with: .now)
    }
    
    func isSameDay(with date: Date) -> Bool {
        Calendar.current.compare(self, to: date, toGranularity: .day) == .orderedSame
    }
    
    func sameDay(at position: WeekPosition) -> Date {
        (Calendar.current.date(byAdding: .day, value: position.rawValue, to: self) ?? .now).startOfTheDay
    }

}
