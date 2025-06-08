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
    }
}
