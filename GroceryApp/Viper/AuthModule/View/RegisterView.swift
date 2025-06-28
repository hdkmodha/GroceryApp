//
//  RegisterView.swift
//  GroceryApp
//
//  Created by Hardik Modha on 28/06/25.
//

import SwiftUI


struct RegisterView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    
    var presenter: AuthPresenter
    
    init(presenter: AuthPresenter) {
        self.presenter = presenter
    }
    
    private func register() async {
        await presenter.login(email: username, password: password)
    }
    
    var body: some View {
        Form {
            TextField("username", text: $username)
            SecureField("password", text: $password)
            HStack {
                Button("Register") {
                    Task {
                        await self.register()
                    }
                }
                Spacer()
                Button("Login") {
                    dismiss()
                }
            }
            if let errorMessage = presenter.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.large)
    }
}
