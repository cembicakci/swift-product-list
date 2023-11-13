//
//  storeApp.swift
//  store
//
//  Created by Cem Bıçakcı on 13.11.2023.
//

import SwiftUI

@main
struct storeApp: App {
    
    @StateObject private var storeModel = StoreModel()
    
    var body: some Scene {
        WindowGroup {
            CategoryListScreen()
                .environmentObject(storeModel)
        }
    }
}
