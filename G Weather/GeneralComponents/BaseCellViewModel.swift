//
//  BaseCellViewModel.swift
//  G Weather
//
//  Created by Andrei Ionescu on 10.08.2024.
//

import Foundation

protocol BaseCellViewModel {
    var cellIdentifier: String { get }
    var hashingID: String { get }
}
