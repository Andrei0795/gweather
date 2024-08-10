//
//  UIStoryboard+Utils.swift
//  G Weather
//
//  Created by Andrei Ionescu on 10.08.2024.
//

import Foundation

import UIKit

enum Storyboard: String {
    case main = "Main"
}

fileprivate extension Storyboard {
    private var current: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
}

extension Storyboard {
    var rootViewController: UIViewController? {
        return current.instantiateInitialViewController()
    }
    
    var initialViewController: UIViewController? {
        return current.instantiateInitialViewController()
    }
    
    func loadViewController<T: UIViewController>() -> T {
        if let loadedVC = current.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
            return loadedVC
        }
        fatalError("View Controller does not have the same Storyboard identifier as its class name")
    }
}
