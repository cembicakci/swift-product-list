//
//  StoreHTTPClient.swift
//  store
//
//  Created by Cem Bıçakcı on 13.11.2023.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidResponse
    case decodingError
    case invalidServerResponse
    case invalidURL
}

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var headers: [String: String] = ["Content-Type": "application/json"]
    var method: HttpMethod = .get([])
}

class StoreHTTPClient {
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.headers
        request.httpMethod = resource.method.name
        
        switch resource.method {
        case .get(let queryItems):
            
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            //https://platzi.com/products?sort=asc&limit=10
            
            guard let url = components?.url else {
                throw NetworkError.badUrl
            }
            
            request.url = url
            
        case .post(let data):
            request.httpBody = data
            
        default:
            break
            
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else { throw NetworkError.invalidResponse }
                
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
        
    }
    
    /*
    func getCategories(url: URL) async throws -> [Category] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return categories
        
    }
    
    func getProductsByCategory(url: URL) async throws -> [Product] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            throw NetworkError.decodingError
        }
        return products
        
    }
     */
    
}
