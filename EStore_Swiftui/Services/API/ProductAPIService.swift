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
    
    //FETCH PRODUCT
    func fetchProductByCategory(categoryId: Int) async throws -> [Product] {
        guard let url = Constant.Endpoint.productsByCategory(categoryId).fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let data = try await NetworkService.shared.fetchData(from: url)
        
        let products = try JSONDecoder().decode([Product].self, from: data)
        
        return products
        
    }
}

//CREATE PRODUCT
extension ProductAPIService {
    func createProduct(title: String, price: Double, description: String, categoryId: Int, images: [String]) async throws -> Product {
        
        guard let url = Constant.Endpoint.createProduct.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newProductDate = CreateProduct(title: title, price: price, description: description, categoryId: categoryId, images: images)
        
        request.httpBody = try JSONEncoder().encode(newProductDate)
        let data = try await NetworkService.shared.postData(with: request)
        
        let createdProduct = try JSONDecoder().decode(Product.self, from: data)
        
        return createdProduct
    }
}

