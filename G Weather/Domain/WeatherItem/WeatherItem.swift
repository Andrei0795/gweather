//
//  WeatherItem.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation

struct WeatherItem {
    var weatherMO: WeatherMO
    private let formatter = ISO8601DateFormatter()
    
    private var startDate: Date? {
        guard let startDate = weatherMO.startDate else {
            return nil
        }
        return formatter.date(from: startDate)
    }
    
    private var endDate: Date? {
        guard let endDate = weatherMO.endDate else {
            return nil
        }
        
        return formatter.date(from: endDate)
    }
    
    var startDateString: String? {
        return startDate?.toHumanReadableString() 
    }
    
    var endDateString: String? {
        return endDate?.toHumanReadableString()
    }
    
    var senderName: String {
        weatherMO.senderName
    }
    
    var eventName: String {
        weatherMO.eventName
    }
    
    var duration: String {
        guard let startDate = startDate, let endDate = endDate else {
            return "cannot_compute_duration".localized
        }
        return startDate.duration(to: endDate)
    }

    var imageLinkString: String {
        return AppConfiguration.weatherAlertsImageLink
    }
    
    init(weatherMO: WeatherMO) {
        self.weatherMO = weatherMO
        formatter.formatOptions = [.withInternetDateTime]
    }
}
