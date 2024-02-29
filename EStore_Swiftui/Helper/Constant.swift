//
//  Constant.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import Foundation

struct Constant {
    static let baseURL = "https://api.escuelajs.co/api/"
    static let apiVersion = "v1"
    static let endpoint = "users"
    
    static let registerView = "Registration"
    
    static func fullEndpoint() -> URL? {
        let fullURLString = URL(string: "\(baseURL)\(apiVersion)/\(endpoint)")
        return fullURLString
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
