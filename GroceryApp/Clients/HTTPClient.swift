//
//  HTTPClient.swift
//  GroceryApp
//
//  Created by Hardik Modha on 07/06/25.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse
    
    
}

enum HTTPMethod: CustomStringConvertible {
    case get(urlQueryItems: [URLQueryItem]? = nil)
    case post(data: Data?)
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "get".uppercased()
        case .post:
            return "post".uppercased()
        case .delete:
            return "delete".uppercased()
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get(urlQueryItems: nil)
    var modelType: T.Type
}

struct HTTPClient {
    
    func load<T: Codable>(resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
        case .get(let urlQueryItems):
            var componenets = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            componenets?.queryItems = urlQueryItems
            guard let url = componenets?.url else {
                throw NetworkError.badRequest
            }
            request = URLRequest(url: url)
            request.httpMethod = resource.method.description
        case .post(let data):
            request.httpBody = data
            request.httpMethod = resource.method.description
        case .delete:
            request.httpMethod = resource.method.description
        }
        
        let configuation = URLSessionConfiguration.default
        configuation.httpAdditionalHeaders = ["Content-Type":"application/json"]
        let session = URLSession(configuration: configuation)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(resource.modelType, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
