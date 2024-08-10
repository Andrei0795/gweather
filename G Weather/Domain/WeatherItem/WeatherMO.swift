//
//  WeatherMO.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let features: [Feature]
}

struct Feature: Decodable {
    let properties: WeatherMO
}

struct WeatherMO: Decodable {
    var startDate: String?
    var endDate: String?
    var senderName: String
    var eventName: String
    
    enum CodingKeys: String, CodingKey {
        case startDate = "effective"
        case endDate = "ends"
        case senderName
        case eventName = "event"
    }
}
