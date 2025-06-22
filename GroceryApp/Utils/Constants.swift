//
//  Constants.swift
//  GroceryApp
//
//  Created by Hardik Modha on 07/06/25.
//

import Foundation

enum Constants {
    
    private static let baseURL = "http://localhost:8080/api"
    static let token = "token"
    static let userId = "userId"
    
    enum endPoints {
        static let register = URL(string: "\(baseURL)/register")!
        static let login = URL(string: "\(baseURL)/login")!
        static func saveGroceryCategory(withId userId: String) -> URL {
            return URL(string: "\(baseURL)/users/\(userId)/grocery-categories")!
        }
        
        static func getGroceryCategories(withId userId: String) -> URL {
            return URL(string: "\(baseURL)/users/\(userId)/grocery-categories")!
        }
        
        static func deleteGroceryCategory(withUserId userId: UUID, andGorceryId groceryId: UUID) -> URL {
            return URL(string: "\(baseURL)/users/\(userId)/grocery-categories/\(groceryId)")!
        }
        
        static func saveGroceryItem(withId groceryCategoryId: UUID, andUserId userId: UUID) -> URL {
            return URL(string: "\(baseURL)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
        }
        
        static func getGroceryItems(withId groceryCategoryId: UUID, andUserId userId: UUID) -> URL {
            return URL(string: "\(baseURL)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
        }
    }
}
