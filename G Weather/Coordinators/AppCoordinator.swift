//
//  AppCoordinator.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    var homeCoordinator: HomeCoordinator!
    private (set) var window: UIWindow!

    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        setupAppContext()
        startHomeCoordinator()
    }
    
    private func startHomeCoordinator() {
        homeCoordinator = HomeCoordinator()
        homeCoordinator.appContext = appContext
        homeCoordinator.start()
        start(homeCoordinator)
        window.rootViewController = homeCoordinator.homeViewController
    }
    
    private func setupAppContext() {
        appContext = AppContext.defaultContext()
    }
}
