//
//  AddProduct.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import SwiftUI

struct AddProduct: View {
    @StateObject private var addVM = ProductVM()
    
    var newProduct = CreateProduct(title: "Monitor Xiaomi", price: 1000, description: "This is another testing from iSwift", categoryId: 2, images: ["https://i.imgur.com/BG8J0Fj.jpg", "https://i.imgur.com/ujHBpCX.jpg"])
    
    @State private var productImage = UIImage(named: "newphoto")!
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20){
                Text("Submit new product")
                    .font(.headline)
                    .padding()
                
                Image(uiImage: productImage)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom)
                
                Button("Submit product") {
                    Task {
                        await submitProduct()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Form Poduct")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func submitProduct() async {
        
        let imageUrls = newProduct.images.map{
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        await addVM.addProduct(title: newProduct.title, price: newProduct.price, description: newProduct.description, categoryId: newProduct.categoryId, images: imageUrls)
    }
}

#Preview {
    AddProduct()
}
