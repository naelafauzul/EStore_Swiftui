//
//  DetailProductView.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 14/03/24.
//

import SwiftUI

struct DetailProductView: View {
    let product: Product
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                HStack (spacing: 10){
                    ForEach(product.images, id: \.self) { imageUrl in
                        if let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                case .failure(_):
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                    }
                }
                .padding()
                VStack(alignment: .leading) {
                    HStack() {
                        Image(systemName: "info.circle.fill")
                        Text("Product Info")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    HStack {
                        Text("Price :")
                            .font(.headline)
                        Text(String(format: "$%.2f", product.price))
                    }
                    .padding(.bottom, 5)
                    
                    VStack (alignment: .leading){
                        Text("Description:")
                            .font(.headline)
                        Text(product.description)
                    }
                    .padding(.bottom, 5)
                        
                }
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(.gray.opacity(0.1))
                
                Spacer()
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(.horizontal, 16)
        
    }
}

#Preview {
    DetailProductView(product: Product.dummy[0])
}
