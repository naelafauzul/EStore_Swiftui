//
//  Category.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import Foundation

struct Category: Codable, Identifiable {
    var id: Int
    var name: String
    var image: String
}

extension Category {
    static var dummy: Category {
        Category(id: 1, name: "Fashion", image: "fashion")
    }
}
