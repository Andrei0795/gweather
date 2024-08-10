//
//  HomeViewController.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import UIKit
import Combine

class HomeViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    var diffableDatasource: BaseTableDiffableDatasource!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupBindings()
        setupDatasource()
        viewModel.fetchWeatherAlerts()
    }
    
    private func setupBindings() {
        viewModel.shouldReloadTablePublisher.sink { [unowned self] in
            configureDatasource(cellVMs: viewModel.weatherCellVMs)
        }.store(in: &cancellables)
        
        viewModel.isLoadingPublisher.sink { [unowned self] loading in
            loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }.store(in: &cancellables)
    }
    
    //MARK: Table Configuration
    private func configureTableView() {
        WeatherAlertCell.register(to: tableView)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupDatasource() {
        diffableDatasource = BaseTableDiffableDatasource(tableView: tableView)
    }
    
    private func configureDatasource(cellVMs: [WeatherAlertCellVM], rowAnimation: UITableView.RowAnimation = .none) {
        var initialSnapshot = NSDiffableDataSourceSnapshot<String, DiffableDatasourceItem<BaseCellViewModel>>()
        
        let categoryItems = cellVMs.map { DiffableDatasourceItem(cellVM: $0) }
        
        initialSnapshot.appendSections([HomeSection.main.rawValue])
        initialSnapshot.appendItems(categoryItems, toSection: HomeSection.main.rawValue)

        
        diffableDatasource.defaultRowAnimation = rowAnimation
        diffableDatasource.apply(initialSnapshot, animatingDifferences: false)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        viewModel.releaseImagesFromMemory()
    }
}
