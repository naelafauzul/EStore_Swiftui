//
//  CreateProduct.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import Foundation

struct CreateProduct: Codable {
    var title: String
    var price: Double
    var description: String
    var categoryId: Int
    var images: [String]
}
