//
//  LoginScreen.swift
//  GroceryApp
//
//  Created by Hardik Modha on 08/06/25.
//

import SwiftUI

struct LoginScreen: View {
    
    @Environment(NavigationViewModel.self) private var viewModel
    
    var groceryModel: GroceryModels
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMesage: String = ""
    @State private var isLoggedIn: Bool = false
    
    var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 10)
    }
    
    func login() async {
        do {
            self.isLoggedIn = try await groceryModel.login(username: username, password: password)
            if isLoggedIn {
                viewModel.push(.categoryList)
            }
        } catch {
            errorMesage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            HStack {
                Button("Login") {
                    Task {
                        await login()
                    }
                }
                .buttonStyle(.borderless)
                .disabled(!isFormValid)
                
            }
            
            if !errorMesage.isEmpty {
                Text(errorMesage)
                    .foregroundStyle(.red)
            }
        }
    }
}

//#Preview {
//    LoginScreen()
//        .environmentObject(GroceryModels())
//}
