//
//  HomeViewModel.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation
import Combine

enum HomeSection: String {
    case main = "main"
}

class HomeViewModel {
    var shouldReloadTablePublisher = PassthroughSubject<Void, Never>()
    var showErrorPublisher = PassthroughSubject<Error, Never>()
    var isLoadingPublisher = PassthroughSubject<Bool, Never>()

    private var networkService: NetworkServiceProtocol
    private var weatherItems = [WeatherItem]()
    var weatherCellVMs = [WeatherAlertCellVM]()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchWeatherAlerts() {
        isLoadingPublisher.send(true)
        Task { @MainActor in
            do {
                let weatherAlerts = try await networkService.fetchWeatherAlerts()
                
                weatherCellVMs = weatherAlerts.map{
                    let item = WeatherItem(weatherMO: $0)
                    weatherItems.append(item)
                    return WeatherAlertCellVM(weatherItem: item)
                }
                shouldReloadTablePublisher.send()
                isLoadingPublisher.send(false)
            } catch {
                showErrorPublisher.send(error)
                print("Failed to fetch weather alerts: \(error)")
            }
        }
    }
    
    func releaseImagesFromMemory() {
        for weatherCellVM in weatherCellVMs {
            weatherCellVM.weatherImage = nil
        }
    }
}
