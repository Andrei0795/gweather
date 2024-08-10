//
//  BaseViewController.swift
//  G Weather
//
//  Created by Andrei Ionescu on 10.08.2024.
//

import UIKit

class BaseViewController: UIViewController, DeinitObservable {
    var deinitSubscriber: DeinitSubscriber?
    var noContentLabel: UILabel?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
    }
    
    deinit {
        deinitSubscriber?.didDeinit(self)
    }
    
    func configureActivityIndicator() {
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.stopAnimating()
    }
}
