//
//  APIManager.swift
//  GroceryApp
//
//  Created by Hardik Modha on 28/06/25.
//


import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int)
}

struct WebResouce<T: Codable> {
    var url: URL
    var method: HTTPMethod
    var modelType: T.Type
}


final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func request<T: Decodable>(resource: WebResouce<T>) async -> Result<T, APIError> {
        
        let configuation = URLSessionConfiguration.default
        configuation.httpAdditionalHeaders = ["Content-Type":"application/json"]
        let session = URLSession(configuration: configuation)
        
        var request: URLRequest
        
        switch resource.method {
        case .get(let urlQueryItems):
            var componenets = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            componenets?.queryItems = urlQueryItems
            guard let url = componenets?.url else {
                return .failure(.invalidURL)
            }
            request = URLRequest(url: url)
        case .post(let data):
            request = URLRequest(url: resource.url)
            request.httpBody = data
        case .delete:
            request = URLRequest(url: resource.url)
        }
        
        request.httpMethod = resource.method.description
        
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                throw APIError.serverError(statusCode: httpResponse.statusCode)
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch {
                return .failure(APIError.decodingError(error))
            }
            
        } catch {
            return .failure(APIError.requestFailed(error))
        }
    }
}
