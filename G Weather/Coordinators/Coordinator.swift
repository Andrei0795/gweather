//
//  Coordinator.swift
//  G Weather
//
//  Created by Andrei Ionescu on 10.08.2024.
//

import Foundation

//MARK: Protocols
protocol DeinitSubscriber: AnyObject {
    func didDeinit(_ observable: DeinitObservable)
}

protocol DeinitObservable: AnyObject {
    var deinitSubscriber: DeinitSubscriber? { get set }
}

protocol CoordinatorProtocol: DeinitSubscriber, DeinitObservable {
    var childCoordinators: [String: CoordinatorProtocol] { get set }
    var appContext: AppContextProtocol! { get set }

    func identifier() -> String
    static func identifier() -> String
    
    func start()
    func start(_ coordinator: CoordinatorProtocol)
    
    func retain(_ coordinator: CoordinatorProtocol)
    func release(_ coordinator: CoordinatorProtocol)
}

extension CoordinatorProtocol {
    func identifier() -> String {
        return String(String(describing: type(of: self)))
    }
    
    static func identifier() -> String {
        return String(describing: self)
    }
    
    func retain(_ coordinator: CoordinatorProtocol) {
        childCoordinators[coordinator.identifier()] = coordinator
    }

    func release(_ coordinator: CoordinatorProtocol) {
        for childCoordinator in coordinator.childCoordinators.values {
            release(childCoordinator)
        }
        
        childCoordinators[coordinator.identifier()] = nil
    }
    
    func releaseAll() {
        childCoordinators.removeAll()
    }
    
    func didDeinit(_ observable: DeinitObservable) {
        switch observable {
        case let deinitedCoordinator as CoordinatorProtocol:
            release(deinitedCoordinator)
        default:
            deinitSubscriber?.didDeinit(self)
        }
    }
}

class Coordinator: NSObject, CoordinatorProtocol {
    var childCoordinators: [String : CoordinatorProtocol] = [:]
    
    weak var deinitSubscriber: DeinitSubscriber?
    var appContext: AppContextProtocol!
    
    func start() {
        assertionFailure("This should be overriden!")
    }
    
    func start(_ coordinator: CoordinatorProtocol) {
        coordinator.deinitSubscriber = self
        coordinator.appContext = appContext
        retain(coordinator)
        coordinator.start()
    }
}
