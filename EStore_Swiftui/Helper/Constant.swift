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
    //    static let endpoint = "users"
    //
    //    static let registerView = "Registration"
    //
    //    static func fullEndpoint() -> URL? {
    //        let fullURLString = URL(string: "\(baseURL)\(apiVersion)/\(endpoint)")
    //        return fullURLString
    //    }
    //}
    
    enum Endpoint {
        case users
        case productsByCategory(Int)
        
        func path() -> String {
            switch self {
            case .users:
                return "users"
            case .productsByCategory(let categoryId):
                return "categories/\(categoryId)/products"
            }
        }
        
        func fullURLEndpoint() -> URL? {
            let fullURL = URL(string: "\(baseURL)\(apiVersion)/\(self.path())")
            return fullURL
        }
    }
    
    static let registerView = "Registration"
    static let usersList = "List of User"
}
    
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    enum FailedMessage {
        static let nonConnectedToInternet = "The internet connection appears to be offline. Please try again or tap refresh button"
        static let timeout = "The network request timed out"
        static let unexpected = "An unexpected network error occured."
        
    }
    
