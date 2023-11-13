//
//  URL+Extensions.swift
//  store
//
//  Created by Cem Bıçakcı on 13.11.2023.
//

import Foundation

extension URL {
    
    static var development: URL {
        URL(string: "https://api.escuelajs.co")!
    }
    
    static var production: URL {
        URL(string: "https://api.escuelajs.co")!
    }
    
    static var `default`: URL {
        #if DEBUG
        return development
        #else
        return production
        #endif
    }
    
    static var allCategories: URL {
        URL(string: "/api/v1/categories", relativeTo: Self.default)!
    }
    
    static func productByCategory(_ categoryId: Int) -> URL {
        return URL(string: "/api/v1/categories/\(categoryId)/products", relativeTo: Self.default)!
    }
    
}
