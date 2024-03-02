//
//  ProductRowView.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 16) {
            if let imageURL = product.images.first, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case.success(let image):
                        image.resizable()
                    case .failure(_):
                        Image(.fashion)
                            .resizable()
                        
                    @unknown default:
                        EmptyView()
                        
                    }
                }
                .frame(width: 80, height: 80)
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(product.description)
                    .font(.subheadline)
                    .lineLimit(2)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ProductRowView(product: Product.dummy[0])
}
