//
//  Product.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var images: [String]
    var category: Category
}

extension Product {
    static var dummy: [Product] = [
        Product(id: 180, title: "nike air jordan", price: 3000, description: "limited edition", images: ["https://i.imgur.com/qNOjJje.jpeg", "https://i.imgur.com/9qrmE1b.jpeg"], category: Category.dummy)
    ]
}
