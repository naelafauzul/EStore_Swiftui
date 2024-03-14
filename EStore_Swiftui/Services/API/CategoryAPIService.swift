//
//  CategoryAPIService.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 14/03/24.
//

import Foundation
import UIKit
import Alamofire

class CategoryAPIService {
    static let shared = CategoryAPIService()
    
    // private init() {}
    
    // MARK: - GET CATEGORY
    func fetchCategory() async throws -> [Category] {
        guard let url = Constant.Endpoint.categories.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        let data = try await NetworkService.shared.fetchData(from: url)
        let categories = try JSONDecoder().decode([Category].self, from: data)
        return categories
    }
}
