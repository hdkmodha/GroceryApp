//
//  RegistrationScreen.swift
//  GroceryApp
//
//  Created by Hardik Modha on 07/06/25.
//

import SwiftUI


struct RegistrationScreen: View {
    
    @EnvironmentObject var groceryModel: GroceryModels
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMesage: String = ""
    
    var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 10)
    }
    
    func register() async {
        do {
            
            let result = try await groceryModel.register(username: self.username, password: self.password)
            print(result)
            
            if !result.error {
                
            } else {
                errorMesage = result.reason ?? ""
            }
            
        } catch {
            self.errorMesage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
            SecureField("Password", text: $password)
            HStack {
                Button("Register") {
                    Task {
                        await register()
                    }
                }
                .buttonStyle(.borderless)
                .disabled(!isFormValid)
                Spacer()
                Button("Login") {
                    
                }
                .buttonStyle(.borderless)
            }
            
            if !errorMesage.isEmpty {
                Text(errorMesage)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    RegistrationScreen()
}
