//
//  Locale+Extensions.swift
//  store
//
//  Created by Cem Bıçakcı on 13.11.2023.
//

import Foundation

extension Locale {
    
    static var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
}
