//
//  GroceryModels.swift
//  GroceryApp
//
//  Created by Hardik Modha on 07/06/25.
//

import Foundation
import GroceryAppSharedDTO

class GroceryModels: ObservableObject {
    
    @Published var groceryCategories: [GroceryCategoryResponseDTO] = []
    
    let httpClient = HTTPClient()
    
    func register(username: String, password: String) async throws -> RegisterResponseDTO {
        let registerData = ["username": username, "password": password]
        let resource = try Resource(url: Constants.endPoints.register, method: .post(data:  JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
        
        let registerResponseDTO = try await httpClient.load(resource: resource)
        print(registerResponseDTO)
        return registerResponseDTO
    }
    
    func login(username: String, password: String) async throws -> Bool {
        let loginPostData = ["username": username, "password": password]
        let resource = try Resource(url: Constants.endPoints.login, method: .post(data: JSONEncoder().encode(loginPostData)), modelType: LoginResponseDTO.self)
        let response = try await httpClient.load(resource: resource)
        
        print(response)
        
        if let token = response.token {
            UserDefaults.standard.set(token, forKey: Constants.token)
            UserDefaults.standard.set(response.userId.uuidString, forKey: Constants.userId)
            UserDefaults.standard.synchronize()
            return true
        } else {
            throw NetworkError.serverError("Unable to login.")
        }
    }
    
    func getGroceryCategories() async throws {
        
        guard let userId = UserDefaults.standard.userId else {
            return 
        }
        
        let url = Constants.endPoints.saveGroceryCategory(withId: userId.uuidString)
        
        let resource = Resource(url: url, modelType: [GroceryCategoryResponseDTO].self)
        let result = try await httpClient.load(resource: resource)
        
        self.groceryCategories = result
    }
    
    func saveGroceryCategory(_ groceryRequestDTO: GroceryCategoryRequestDTO) async throws {
        
        guard let userId = UserDefaults.standard.userId else { return
        }
        
        let url = Constants.endPoints.saveGroceryCategory(withId: userId.uuidString)
        let resource = try Resource(url: url, method: .post(data: JSONEncoder().encode(groceryRequestDTO)), modelType: GroceryCategoryResponseDTO.self)
        
        let result = try await httpClient.load(resource: resource)
        
        print(result)
        
        self.groceryCategories.append(result)
        
    }
}
