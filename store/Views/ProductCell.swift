//
//  ProductCell.swift
//  store
//
//  Created by Cem Bıçakcı on 13.11.2023.
//

import SwiftUI

struct ProductCell: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .firstTextBaseline) {
                Text(product.title)
                    .bold()
                
                Spacer()
                
                Text(product.price, format: .currency(code: Locale.currencyCode))
                    .padding(5)
                    .foregroundColor(.white)
                    .background {
                        Color.green
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))

            }
            Text(product.description)
            
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product.preview)
    }
}
