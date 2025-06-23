//
//  GroceryModels.swift
//  GroceryApp
//
//  Created by Hardik Modha on 07/06/25.
//

import Foundation
import GroceryAppSharedDTO

@MainActor
class GroceryModels: ObservableObject {
    
    @Published var groceryCategories: [GroceryCategoryResponseDTO] = []
    
    @Published var groceryItems:[GroceryItemResponseDTO] = []
    
    @Published var groceryCategory: GroceryCategoryResponseDTO?
    
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
            UserDefaults.standard.userId = response.userId
            UserDefaults.standard.token = response.token
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
    
    func deleteGroceryCategory(withId id: UUID) async throws {
        
        guard let userId = UserDefaults.standard.userId else { return }
        let url = Constants.endPoints.deleteGroceryCategory(withUserId: userId, andGorceryId: id)
        let resource = Resource(url: url, method: .delete, modelType: GroceryCategoryResponseDTO.self)
        let result = try await httpClient.load(resource: resource)
        
        self.groceryCategories = groceryCategories.filter({$0.id != result.id})
        
        
        print(result)
    }
    
    func saveGroceryItem(withId categoryId: UUID, andRequestDTO groceryItemRequestDTO: GroceryItemRequestDTO) async throws {
        
        guard let userId = UserDefaults.standard.userId else {
            return 
        }
        
        let url = Constants.endPoints.saveGroceryItem(withId: categoryId, andUserId: userId)
        
        let resource = try Resource(url: url, method: .post(data: JSONEncoder().encode(groceryItemRequestDTO)), modelType: GroceryItemResponseDTO.self)
        
        let result = try await httpClient.load(resource: resource)
        self.groceryItems.append(result)
            
    }
    
    func getGroceryItems(forCategoryWithId id: UUID) async throws {
        
        guard let userId = UserDefaults.standard.userId else { return
        }
        
        let url = Constants.endPoints.getGroceryItems(withId: id, andUserId: userId)
        
        let resource = Resource(url: url, modelType: [GroceryItemResponseDTO].self)
        
        self.groceryItems.removeAll()
        
        self.groceryItems = try await httpClient.load(resource: resource)
    }
    
    func deleteGroceryItems(withCategoryId categoryId: UUID, andItem groceryItem: GroceryItemResponseDTO) async throws {
        
        guard let userId = UserDefaults.standard.userId else { return }
        let url = Constants.endPoints.deleteGroceryItems(withId: categoryId, andUserId: userId, andItemId: groceryItem.id)
        
        let reousce = Resource(url: url, method: .delete, modelType: GroceryItemResponseDTO.self)
        let result = try await httpClient.load(resource: reousce)
        
        if let index = self.groceryItems.firstIndex(of: groceryItem) {
            self.groceryItems.remove(at: index)
        }
        
        
    }
    
    func logout() {
        UserDefaults.standard.userId = nil
        UserDefaults.standard.token = nil
    }
}
