//
//  Date+Today.swift
//  Today
//
//  Created by Anh Tran on 3/14/23.
//

import Foundation
extension Date {
    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at formatted time string")
            return String(format: timeFormat, timeText)
            
        } else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormat = NSLocalizedString("due on %@ at %@", comment: "Due on <date formatted string> at <time formatted string>")
            return String(format: dateAndTimeFormat, dateText, timeText)
        }
    }
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today due date description")
        } else {
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
