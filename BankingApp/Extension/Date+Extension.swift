//
//  Date+Extension.swift
//  BankingApp
//
//  Created by junil on 7/1/25.
//

import Foundation

extension Date {
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        return formatter.string(from: self)
    }
}
