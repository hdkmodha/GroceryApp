//
//  AuthInteractor.swift
//  GroceryApp
//
//  Created by Hardik Modha on 28/06/25.
//


import Foundation
import GroceryAppSharedDTO

protocol Interactor {
    func login(username: String, password: String) async -> Result<LoginResponseDTO, APIError>
    func register(username: String, password: String) async -> Result<RegisterResponseDTO, APIError>
}

class AuthInteractor: Interactor {
    
    private let manager = APIManager.shared
    
    func login(username: String, password: String) async -> Result<LoginResponseDTO, APIError> {
        let parameters = ["username": username, "password": password]
        let resource = WebResouce(url: Constants.endPoints.login, method: .post(data: try? JSONEncoder().encode(parameters)), modelType: LoginResponseDTO.self)
        let result = await manager.request(resource: resource)
        return result
        
    }
    
    func register(username: String, password: String) async -> Result<RegisterResponseDTO, APIError> {
        let parameters = ["username": username, "password": password]
        let resource = WebResouce(url: Constants.endPoints.register, method: .post(data: try? JSONEncoder().encode(parameters)), modelType: RegisterResponseDTO.self)
        let result = await manager.request(resource: resource)
        return result
    }
    
}
