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
    
    @Published var categories: [Category] = []
    @Published private(set) var products: [Product] = []
    
    func fetchCategories() async throws {
        
        categories = try await client.load(Resource(url: URL.allCategories))
        //categories = try await client.getCategories(url: URL.allCategories)
    }
    
    func fetchProductsByCategory(_ categoryId: Int) async throws {
        products = try await client.load(Resource(url: URL.productByCategory(categoryId)))
        //products = try await client.getProductsByCategory(url: URL.productByCategory(categoryId))
    }
    
    func saveProduct(_ createProduct: CreateProduct) async throws {
        
        let data = try JSONEncoder().encode(createProduct)
        let product: Product = try await client.load(Resource(url: URL.saveProduct, method: .post(data)))
        products.append(product)
        
    }
    
}
