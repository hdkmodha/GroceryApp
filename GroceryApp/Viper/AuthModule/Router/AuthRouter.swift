//
//  AuthRouter.swift
//  GroceryApp
//
//  Created by Hardik Modha on 28/06/25.
//

import Foundation
import SwiftUI
import Observation

enum Destination: Hashable, Identifiable {
    case register
    
    var id: Self {
        return self
    }
}


protocol Router {
    associatedtype ContentView: View
    static func start() -> ContentView
}

@Observable
class AuthRouter: Router {
    
    typealias ContentView = AuthNavigationView
    
    var navigationPath: NavigationPath = NavigationPath()
    var destination: Destination?
    
    static func start() -> ContentView {
        let router = AuthRouter()
        let presenter = AuthPresenter()
        let interactor = AuthInteractor()
        
        presenter.interactor = interactor
        presenter.router = router
        
        return AuthNavigationView(router: router, presenter: presenter)
    }
}

extension AuthRouter {
    func sheet(withDesitnation destination: Destination) {
        self.destination = destination
    }
}
