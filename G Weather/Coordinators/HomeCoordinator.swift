//
//  HomeCoordinator.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation

class HomeCoordinator: Coordinator {
    var homeViewController: HomeViewController!
    
    override init() {
        super.init()
    }
    
    override func start() {
        self.homeViewController = Storyboard.main.loadViewController()
        let viewModel = HomeViewModel(networkService: appContext.networkService)
        self.homeViewController.viewModel = viewModel
    }
}
