//
//  APIServices.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import Foundation

class UserAPIService {
    
    //GET ALL USERS
    func fetchUsers() async throws -> [User] {
        guard let url = Constant.Endpoint.users.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let data = try await NetworkService.shared.fetchData(from: url)
        
        let users = try JSONDecoder().decode([User].self, from: data)
        
        return users
    }
}
