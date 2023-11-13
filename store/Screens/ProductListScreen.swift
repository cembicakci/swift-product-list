//
//  ProductListScreen.swift
//  store
//
//  Created by Cem Bıçakcı on 13.11.2023.
//

import SwiftUI

struct ProductListScreen: View {
    
    let category: Category
    
    @EnvironmentObject private var storeModel: StoreModel

    var body: some View {
        List(storeModel.products, id: \.id) { product in
            ProductCell(product: product)
        }
        .listStyle(.plain)
        .navigationTitle(category.name)
        .task {
            do {
                try await storeModel.fetchProductsByCategory(category.id)
            } catch {
                print(error)
            }
        }
    }
}

struct ProductListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductListScreen(category:
                            Category(
                                id: 1,
                                name: "Clothes",
                                image: URL(string: "https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg")!
                            )
        ).environmentObject(StoreModel())
    }
}
