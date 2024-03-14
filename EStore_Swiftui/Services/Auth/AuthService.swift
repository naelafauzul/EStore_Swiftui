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
    
    // MARK: - REGISTER
    func createUser(with user: User) async throws -> User {
        guard let url = Constant.Endpoint.users.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(user)
        
        let data = try await NetworkService.shared.postData(with: request)
        
        let results = try JSONDecoder().decode(User.self, from: data)
        
        return results
    }
}

// MARK: - LOGIN
extension AuthService {
    func login(email: String, password: String) async throws -> LoginResponse {
        guard let url = Constant.Endpoint.login.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        guard let requestData = try? JSONEncoder().encode(loginRequest) else {
            throw URLError(.cannotParseResponse)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData
        
        // Menggunakan NetworkService untuk mengirim POST request
        let data = try await NetworkService.shared.postData(with: request)
        
        // Decode response
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        return loginResponse
    }
}
