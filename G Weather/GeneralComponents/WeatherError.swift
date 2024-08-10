//
//  WeatherError.swift
//  G Weather
//
//  Created by Andrei Ionescu on 10.08.2024.
//

import Foundation

protocol BaseErrorProtocol {
    var message: String { get }
}

enum WeatherError: Error, BaseErrorProtocol {
    case couldNotFetchData
    case generalError
    
    var message: String {
        switch self {
        case .couldNotFetchData:
            return "general_error_could_not_fetch_data_message".localized
        case .generalError:
            return "general_internet_error_message".localized
        }
    }
}
