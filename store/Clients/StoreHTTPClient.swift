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
    case decodinError
    case invalidServerResponse
    case invalidURL
}

class StoreHTTPClient {
    
    func getCategories(url: URL) async throws -> [Category] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            throw NetworkError.decodinError
        }
        
        return categories
        
    }
    
}
