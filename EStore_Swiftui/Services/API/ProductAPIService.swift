//
//  ProductAPIService.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import Foundation

class ProductAPIService {
    static let shared = ProductAPIService()
    private init() {}
    
    func fetchProductByCategory(categoryId: Int) async throws -> [Product] {
        guard let url = Constant.Endpoint.productsByCategory(categoryId).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let data = try await NetworkService.shared.fetchData(from: url)
        
        let products = try JSONDecoder().decode([Product].self, from: data)
        
        return products
        
    }
}

