//
//  DateParser.swift
//  SquatchNotes
//
//  Created by Hutson on 3/18/21.
//

import Foundation

class DateFormatter : Formatter {
    let dateFormatter = DateFormatter(),
    dateFormatter.dateStyle = .medium,
    dateFormatter.timeStyle = .none
     
    let date = Date(timeIntervalSinceReferenceDate: 118800)
     
    // US English Locale (en_US)
    dateFormatter.locale = Locale(identifier: "en_US")
    print(dateFormatter.string(from: date)) // Jan 2, 2001
}


