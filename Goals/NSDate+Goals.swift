//
//  NSDate+Goals.swift
//  Goals
//
//  Created by Alex Miles on 2/23/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import Foundation

extension NSDate {
    func numberOfDaysUntilDateTime(toDateTime: NSDate, inTimeZone timeZone: NSTimeZone? = nil) -> Int {
        let calendar = NSCalendar.currentCalendar()
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }
        
        var fromDate: NSDate?, toDate: NSDate?
        
        calendar.rangeOfUnit(.Day, startDate: &fromDate, interval: nil, forDate: self)
        calendar.rangeOfUnit(.Day, startDate: &toDate, interval: nil, forDate: toDateTime)
        
        let difference = calendar.components(.Day, fromDate: fromDate!, toDate: toDate!, options: [])
        return difference.day
    }
    
    class func nextDayAtHour(hour: Int) -> NSDate {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        
        // Add +1 day to existing date
        let addComponents = NSDateComponents()
        addComponents.day = 1
        let newDate = calendar.dateByAddingComponents(addComponents, toDate: date, options: [])
        
        // Set the time of the new date to 8
        let components = calendar.components([.Day , .Month , .Year], fromDate: newDate!)
        components.hour = hour
        
        return calendar.dateFromComponents(components)!
    }
    
    func yesterday() -> NSDate {
        let addComponents = NSDateComponents()
        addComponents.day = -1
        return NSCalendar.currentCalendar().dateByAddingComponents(addComponents, toDate: self, options: [])!
    }
    
    func isEqualToDateWithoutTime(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let todayComponents = calendar.components([.Year, .Month, .Day], fromDate: NSDate())
        let dateComponents = calendar.components([.Year, .Month, .Day], fromDate: self)
        return todayComponents.year == dateComponents.year && todayComponents.month == dateComponents.month && todayComponents.day == dateComponents.day
    }
    
    func isYesterday() -> Bool {
        return self.isEqualToDateWithoutTime(NSDate().yesterday())
    }
}