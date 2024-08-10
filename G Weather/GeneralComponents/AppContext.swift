//
//  AppContext.swift
//  G Weather
//
//  Created by Andrei Ionescu on 10.08.2024.
//

import Foundation

protocol AppContextProtocol {
    static func defaultContext() -> AppContextProtocol
    var networkService: NetworkServiceProtocol! { get set }
}

class AppContext: AppContextProtocol {
    var networkService: (any NetworkServiceProtocol)!
    
    static func defaultContext() -> AppContextProtocol {
        return AppContext()
    }
        
    private init() {
        self.networkService = NetworkService()
    }
}
