//
//  AuthNavigationView.swift
//  GroceryApp
//
//  Created by Hardik Modha on 28/06/25.
//

import SwiftUI

struct AuthNavigationView: View {
    
    @State var router: AuthRouter
    var presenter: AuthPresenter
    
    init(router: AuthRouter, presenter: AuthPresenter) {
        self.router = router
        self.presenter = presenter
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            LoginView(presenter: presenter)
                .sheet(item: $router.destination) { destination in
                    switch destination {
                    case .register:
                        RegisterView(presenter: presenter)
                    }
                }
        }
    }
    
    
}
