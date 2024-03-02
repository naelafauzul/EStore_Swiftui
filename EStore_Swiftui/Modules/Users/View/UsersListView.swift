//
//  UsersListView.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 29/02/24.
//

import SwiftUI

struct UsersListView: View {
    @StateObject private var userVM = UsersViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(userVM.users) { user in
                    UserRowView(user: user)
                }
                .onDelete(perform: delete)
            }
            .refreshable {
                await userVM.loadUsers()
            }
            .toolbar {
                EditButton()
            }
            .task {
                await userVM.loadUsers()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        userVM.users.remove(atOffsets: offsets)
    }
}

#Preview {
    UsersListView()
}
