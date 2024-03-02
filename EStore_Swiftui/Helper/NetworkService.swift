//
//  NetworkService.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import Foundation

enum NetworkError: Error {
    case badURLResponse(url: URL)
    case unknown(HTTPURLResponse?)
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    //POST
    func postData(with request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badURLResponse(url: request.url!)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unknown(httpResponse)
        }
        
        return data
    }
    
    //GET
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badURLResponse(url: url)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unknown(httpResponse)
        }
        
        return data
    }
     
}
