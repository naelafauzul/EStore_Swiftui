//
//  AddProduct.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import SwiftUI

struct AddProduct: View {
    @StateObject private var addVM = ProductVM()
    @State private var productImage = UIImage(named: "newphoto")!
    @State private var showPhoto: Bool = false
    @State private var photoSource: PhotoSource?
    
    var newProduct = CreateProduct(
        title: "Shoes and care",
        price: 100,
        description: "New attempt of getting wealth",
        categoryId: 5,
        images: []
    )
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Informasi produk
                    Text("Submit a New Product with Default Values")
                        .multilineTextAlignment(.center)
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
                        .onTapGesture {
                            self.showPhoto.toggle()
                        }
                    
                    // Tombol submit
                    Button("Submit Product") {
                        Task {
                            await submitProduct()
                        }
                    }
                    .disabled(addVM.isLoading)
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .navigationTitle("Add Product")
            .disabled(addVM.isLoading)
            .blur(radius: addVM.isLoading ? 3.0 : 0.0)
            .navigationBarTitleDisplayMode(.inline)
        }
        .confirmationDialog("Choose your photo source", isPresented: $showPhoto, titleVisibility: .visible) {
            Button("Camera") {
                self.photoSource = .camera
            }
            
            Button("Photo Library") {
                self.photoSource = .photoLibrary
            }
        }
        .fullScreenCover(item: $photoSource) { source in
            switch source {
            case .photoLibrary:
                ImagePicker(sourceType: .photoLibrary, selectedImage: $productImage)
                    .ignoresSafeArea()
            case .camera:
                ImagePicker(sourceType: .camera, selectedImage: $productImage)
                    .ignoresSafeArea()
            }
        }
    }
    
    private func submitProduct() async {
        await addVM.addProductWithImage(
            title: newProduct.title,
            price: newProduct.price,
            description: newProduct.description,
            categoryId: newProduct.categoryId,
            image: productImage
        )
    }
}

#Preview {
    AddProduct()
}
