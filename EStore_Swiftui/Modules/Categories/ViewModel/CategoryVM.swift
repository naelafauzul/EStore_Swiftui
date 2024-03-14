//
//  CategoryVM.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 14/03/24.
//

import Foundation
import UIKit

@MainActor
class CategoryVM: ObservableObject {
    @Published var categories: [Category] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - LOAD CATEGORIES
    func loadCategories() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedCategories = try await CategoryAPIService.shared.fetchCategory()
            categories.self = fetchedCategories

        } catch {
            print(error)
            self.errorMessage = "Failed to fetch products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
