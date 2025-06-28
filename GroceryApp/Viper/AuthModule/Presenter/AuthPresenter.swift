//
//  AuthPresenter.swift
//  GroceryApp
//
//  Created by Hardik Modha on 28/06/25.
//

import Foundation
import Observation
import GroceryAppSharedDTO


protocol Presenter {
    func login(email: String, password: String) async
    func register(email: String, password: String) async
}

@Observable
class AuthPresenter: Presenter {
    
    var isLoggedIn: Bool = false
    var errorMessage: String?
    var interactor: AuthInteractor?
    var router: AuthRouter?
    
    func login(email: String, password: String) async {
        let result = await self.interactor?.login(username: email, password: password)
        switch result {
        case .success(let loginResponse):
            print(loginResponse)
            self.saveUserInfo(withResponse: loginResponse)
            isLoggedIn = true
        case .failure(let error):
            errorMessage = error.localizedDescription
            isLoggedIn = false
        case .none:
            isLoggedIn = false
            break
        }
    }
    
    func register(email: String, password: String) async {
        let result = await self.interactor?.register(username: email, password: password)
        switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        case .none:
            break
        }
    }
    
    private func saveUserInfo(withResponse response: LoginResponseDTO) {
        UserDefaults.standard.userId = response.userId
        
        if let token = response.token {
            UserDefaults.standard.token = token
        }
    }
    
    func openRegisterScreen() {
        self.router?.sheet(withDesitnation: .register)
    }
    
    
}
