//
//  AuthViewModel.swift
//  GroceryApp
//
//  Created by Hardik Modha on 13/06/25.
//

import Foundation
import GroceryAppSharedDTO
import Observation
import SwiftUI

enum AppScreen: Hashable {
    case login
    case categoryList
    case register
    case addCategory
}

@Observable
class NavigationViewModel {
    
    var currentRoute: AppScreen
    
    var navigationPath: NavigationPath = NavigationPath()
    
    init(currentRoute: AppScreen) {
        self.currentRoute = currentRoute
    }
    
    func push(_ route: AppScreen) {
        self.navigationPath.append(route)
    }
    
    func pop() {
        self.navigationPath.removeLast()
    }
    
    func popToRoot() {
        self.navigationPath.removeLast(navigationPath.count)
    }
}
