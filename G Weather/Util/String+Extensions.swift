//
//  String+Extensions.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation

extension String {
    func asReadableDateString() -> String? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: self)
        
        return date?.toHumanReadableString()
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
