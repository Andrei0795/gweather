//
//  BaseTableDiffableDatasource.swift
//  G Weather
//
//  Created by Andrei Ionescu on 10.08.2024.
//

import UIKit

struct DiffableDatasourceItem<T>: Hashable {
    var identifier: String
    var cellViewModel: T
    
    static func == (lhs: DiffableDatasourceItem<T>, rhs: DiffableDatasourceItem<T>) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension DiffableDatasourceItem where T == BaseCellViewModel {
    init(cellVM: BaseCellViewModel) {
        self.init(identifier: cellVM.hashingID, cellViewModel: cellVM)
    }
}

class BaseTableDiffableDatasource: UITableViewDiffableDataSource<String, DiffableDatasourceItem<BaseCellViewModel>> {
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cellViewModel = itemIdentifier.cellViewModel
            let cellID = cellViewModel.cellIdentifier
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? BaseTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = cellViewModel
            return cell
        }
    }
}
