//
//  CreateProduct.swift
//  store
//
//  Created by Cem Bıçakcı on 19.11.2023.
//

import Foundation

struct CreateProduct: Encodable {
    
    let title: String
    let price: Double
    let description: String
    let categoryId: Int
    let images: [URL]
    
}
