//
//  User.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int?
    var email, password, name: String
    var avatar: String
    var role: String?
}

//dummy data
extension User {
    static var dummy: User {
        User(id: 1,
             email: "test@mail.com",
             password: "qwerty",
             name: "Test User", 
             avatar: "https://i.pravatar.cc/150?img=3")
    }
}
