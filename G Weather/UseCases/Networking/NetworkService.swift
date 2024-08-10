//
//  NetworkService.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchWeatherAlerts() async throws -> [WeatherMO]
}

class NetworkService: NetworkServiceProtocol {
    func fetchWeatherAlerts() async throws -> [WeatherMO] {
        let url = AppConfiguration.weatherAlertsURLString
        
        let dataTask = AF.request(url).serializingDecodable(WeatherResponse.self)
        
        do {
            let weatherResponse = try await dataTask.value
            let weatherAlerts = weatherResponse.features.map { $0.properties }
            return weatherAlerts
        } catch {
            throw error
        }
    }
}
