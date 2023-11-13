//
//  StoreModel.swift
//  store
//
//  Created by Cem Bıçakcı on 13.11.2023.
//

import Foundation

@MainActor
class StoreModel: ObservableObject {
    
    let client = StoreHTTPClient()
    
    @Published private(set) var categories: [Category] = []
    @Published private(set) var products: [Product] = []
    
    func fetchCategories() async throws {
        categories = try await client.getCategories(url: URL.allCategories)
    }
    
    func fetchProductsByCategory(_ categoryId: Int) async throws {
        print(categoryId)
        products = try await client.getProductsByCategory(url: URL.productByCategory(categoryId))
    }
    
}
