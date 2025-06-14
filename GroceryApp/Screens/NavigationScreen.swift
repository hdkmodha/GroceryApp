//
//  NavigationScreen.swift
//  GroceryApp
//
//  Created by Hardik Modha on 13/06/25.
//

import SwiftUI


struct NavigationView: View {
    
    private var model: GroceryModels
    
    @State var viewModel: NavigationViewModel = NavigationViewModel(currentRoute: .login)
    
    init(model: GroceryModels) {
        self.model = model
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            LoginScreen(groceryModel: self.model)
                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                    case .addCategory:
                        AddGroceryCategoryScreen()
                    case .categoryList:
                        GroceryCategoryListScreen()
                            .environmentObject(model)
                    case .register:
                        RegistrationScreen()
                    default:
                        EmptyView()
                    }
                }
                
        }
        .environment(self.viewModel)
    }
}

//#Preview {
//    NavigationView()
//}
