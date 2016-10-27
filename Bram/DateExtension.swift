//
//  DateExtension.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-22.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

extension Date {
    static func isSmallerThan(_ date1: Date, _ date2: Date, byDays days: Int = 1) -> Bool {
        let timeInterval = date1.timeIntervalSince(date2)
        return Int(timeInterval) < Date.daysToSeconds(days)
    }
    
    static func isSmallerThanOrEquals(_ date1: Date, _ date2: Date, byDays days: Int = 1) -> Bool {
        let timeInterval = date1.timeIntervalSince(date2)
        return Int(timeInterval) <= Date.daysToSeconds(days)
    }
    
    static func daysToSeconds(_ days: Int) -> Int {
        return days * 86400
    }
    
    static func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        return NSCalendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    static func isPastDay(_ date1: Date, _ date2: Date) -> Bool {
        return date1.isLessThanDate(date2)
    }
    
    static var s: Date {
        return Date().s
    }
    
    var s: Date {
        let cal = Calendar(identifier: .gregorian)
        return cal.startOfDay(for: self)
    }
    
    static var e: Date {
        return Date().e
    }
    
    var e: Date {
        return NSCalendar.current.date(byAdding: .second, value: -1, to: self.addDays(1).s)!
    }
    
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(_ daysToAdd: Int) -> Date {
        
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}
