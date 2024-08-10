//
//  Date+Extensions.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation

extension Date {
    func toHumanReadableString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current // Use the current locale
        return formatter.string(from: self)
    }
    
    func duration(to endDate: Date) -> String {
           let calendar = Calendar.current
           
           //Difference in hours and minutes
           let components = calendar.dateComponents([.hour, .minute], from: self, to: endDate)
           
           //Get hours and minutes
           guard let hours = components.hour, let minutes = components.minute else {
               return "Invalid date difference"
           }
           
           //Human-readable string
           var durationString = ""
           
           if hours > 0 {
               durationString += "\(hours) hour" + (hours > 1 ? "s" : "")
           }
           
           if minutes > 0 {
               if !durationString.isEmpty {
                   durationString += " and "
               }
               durationString += "\(minutes) minute" + (minutes > 1 ? "s" : "")
           }
           
           return durationString.isEmpty ? "0 minutes" : durationString
       }
}
