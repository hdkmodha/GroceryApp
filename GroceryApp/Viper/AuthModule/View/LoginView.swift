//
//  LoginView.swift
//  GroceryApp
//
//  Created by Hardik Modha on 28/06/25.
//


import Foundation
import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var presenter: AuthPresenter
    
    init(presenter: AuthPresenter) {
        self.presenter = presenter
    }
    
    private func login() async {
        await presenter.login(email: username, password: password)
    }
    
    var body: some View {
        Form {
            TextField("username", text: $username)
            SecureField("password", text: $password)
            HStack {
                Button("Login") {
                    Task {
                        await self.login()
                    }
                }
                .buttonStyle(.plain)
                Spacer()
                Button("Register") {
                    self.presenter.openRegisterScreen()
                }
                .buttonStyle(.plain)
            }
            if let errorMessage = presenter.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.large)
    }
}




