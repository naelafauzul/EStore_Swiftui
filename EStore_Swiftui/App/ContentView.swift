//
//  ContentView.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 14/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                CategoriesView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                UsersListView()
            }
            .tabItem {
                Label("User", systemImage: "person")
            }
        }
        .accentColor(.red)
    }
}

#Preview {
    ContentView()
}
