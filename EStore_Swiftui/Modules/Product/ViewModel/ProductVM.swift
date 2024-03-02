//
//  ProductVM.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import Foundation

@MainActor
class ProductVM: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    //LOAD PRODUCT
    func loadProduct(forCategory categoryId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedProducts = try await ProductAPIService.shared.fetchProductByCategory(categoryId: categoryId)
            self.products = fetchedProducts.reversed()
            
        } catch {
            print(error)
            self.errorMessage = "Failde to fetch product: \(error.localizedDescription)"
        }
        
        isLoading = false 
    }
    
}

//ADD PRODUCT
extension ProductVM {
    func addProduct(title: String, price: Double, description: String, categoryId: Int, images: [String]) async {
        isLoading = true
        
        do {
            let createdProduct = try await ProductAPIService.shared.createProduct(title: title, price: price, description: description, categoryId: categoryId, images: images)
            
            products.append(createdProduct)
            print(createdProduct)
        } catch {
            errorMessage = "Failed to create product: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
