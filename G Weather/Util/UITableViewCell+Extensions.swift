//
//  UITableViewCell+Extensions.swift
//  G Weather
//
//  Created by Andrei Ionescu on 09.08.2024.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    static func register(to tableView: UITableView) {
        let nibFile = UINib(nibName: identifier, bundle: nil)
        tableView.register(nibFile, forCellReuseIdentifier: identifier)
    }
}
