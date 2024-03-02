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
    
    func loadProduct(forCategory categoryId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedProducts = try await ProductAPIService.shared.fetchProductByCategory(categoryId: categoryId)
            self.products = fetchedProducts
            
        } catch {
            print(error)
            self.errorMessage = "Failde to fetch product: \(error.localizedDescription)"
        }
        
        isLoading = false 
    }
    
}
