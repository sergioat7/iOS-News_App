//
//  Date.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

extension Date {
    func getString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "es")
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func isEarlierThan(_ date: Date) -> Bool {
        if self.compare(date) == .orderedAscending {
            return true
        }
        else {
            return false
        }
    }
    
    func isLaterThan(_ date: Date) -> Bool {
        if self.compare(date) == .orderedDescending {
            return true
        }
        else {
            return false
        }
    }
    
    func isSame(_ date: Date) -> Bool {
        if self.compare(date) == .orderedSame {
            return true
        }
        else {
            return false
        }
    }
}
