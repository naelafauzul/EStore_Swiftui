//
//  UsersViewModel.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import Foundation

@MainActor
Class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
}
