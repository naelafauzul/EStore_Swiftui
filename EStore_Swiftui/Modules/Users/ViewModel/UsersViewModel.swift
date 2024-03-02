//
//  UsersViewModel.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import Foundation

@MainActor
class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessages: String?
    
    private let service = UserAPIService()
    
    func loadUsers() async {
        isLoading = true
        
        do {
            let loadedUsers = try await service.fetchUsers()
            self.users = loadedUsers.reversed()
        } catch {
            let message = ErrorMessage.message(for: error)
            print("Could not load users data: \(message) because of \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    
}
