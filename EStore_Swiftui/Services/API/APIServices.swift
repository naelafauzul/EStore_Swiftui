//
//  APIServices.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import Foundation

class APIServices {
    
    //GET ALL USERS
    func fetchUsers() async throws -> [User] {
        guard let url = Constant.fullEndpoint() else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
        
        let users = try JSONDecoder().decode([User].self, from: data)
        
        return users
    }
}
