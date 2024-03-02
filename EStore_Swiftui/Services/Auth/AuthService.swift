//
//  AuthService.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func createUser(with user: User) async throws -> User {
        guard let url = Constant.Endpoint.users.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(user)
        
        let data = try await NetworkService.shared.postData(with: request)
        
        let result = try JSONDecoder().decode(User.self, from: data)
        
        return result
    }
}
