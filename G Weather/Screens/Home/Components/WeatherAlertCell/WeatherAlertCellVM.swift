//
//  WeatherAlertCellVM.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation
import Combine
import UIKit

class WeatherAlertCellVM: BaseCellViewModel {
    var fetchedImagePublisher = PassthroughSubject<UIImage?, Never>()

    var cellIdentifier: String {
        return WeatherAlertCell.identifier
    }
    var hashingID: String {
        return cellIdentifier + UUID().uuidString
    }

    var startDateTitleText: String {
        "start_date".localized
    }
    
    var endDateTitleText: String {
        "end_date".localized
    }
    
    var durationTitleText: String {
        "duration".localized
    }
    
    var sentByText: String {
        return String(format: "sent_by".localized, weatherItem.senderName)
    }
    
    var weatherItem: WeatherItem
    var weatherImage: UIImage?
    
    init(weatherItem: WeatherItem) {
        self.weatherItem = weatherItem
    }
    
    func fetchImage() {
        guard weatherImage == nil else {
            fetchedImagePublisher.send(weatherImage)
            return
        }
        
        Task {
            do {
                let image = try await ImageService.shared.fetchImage(from: self.weatherItem.imageLinkString)
                weatherImage = image
                DispatchQueue.main.async { [weak self] in
                    self?.fetchedImagePublisher.send(image)
                }

            } catch {
                print("Failed to fetch image: \(error)")
            }
        }
    }
}
