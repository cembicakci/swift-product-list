//
//  AddProductScreen.swift
//  store
//
//  Created by Cem Bıçakcı on 19.11.2023.
//

import SwiftUI

struct AddProductScreen: View {
    
    @State private var title: String = ""
    @State private var price: Double = 0.0
    @State private var description: String = ""
    @State private var selectedCategory: Category?
    @State private var imageUrl: String = ""
    @State private var errorMessage: String = ""
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var storeModel: StoreModel
    
    private var isFormValid: Bool {
        !title.isEmpty && selectedCategory != nil && !imageUrl.isEmpty && !description.isEmpty && !price.isZero
    }
    
    private func saveProduct() {
        guard let category = selectedCategory,
              let imageURL = URL(string: imageUrl) else { return }
        
        let createProduct = CreateProduct(title: title, price: price, description: description, categoryId: category.id, images: [imageURL])
        
        //storeModel.saveProduct(createProduct)
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Price", value: $price, format: .number)
            TextField("Description", text: $description)
            
            Picker("Categories", selection: $selectedCategory) {
                ForEach(storeModel.categories, id: \.id) { category in
                    Text(category.name)
                }
            }.pickerStyle(.wheel)
            
            TextField("Image Url", text: $imageUrl)
        }
        .navigationTitle("Add Product")
        .onAppear {
            selectedCategory = storeModel.categories.first
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    
                    if isFormValid {
                        saveProduct()
                    }
                    
                }.disabled(!isFormValid)
            }
        }
    }
}

struct AddProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        let storeModel = StoreModel()
        storeModel.categories = [Category(id: 1, name: "Test", image: URL(string: "https://picsum.photos/200/300")!)]
        
        return NavigationStack {
            AddProductScreen().environmentObject(storeModel)
        }
    }
}
