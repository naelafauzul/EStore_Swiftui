//
//  LoginView.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 14/03/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Login") {
                    Task {
                        await loginVM.login(email: email, password: password)
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                
                Group {
                    if loginVM.isLoggedIn{
                        Text("User logged in!!!")
                    }
                    
                    if let message = loginVM.message, !loginVM.isLoggedIn {
                        Text(message)
                            .foregroundStyle(.red)
                    }
                }
                .font(.title3)
                .foregroundStyle(.green)
                .padding()
            }
            .navigationTitle("Login Page")
            .toolbar {
                Button("Logout") {
                    Task {
                        loginVM.logout()
                        clearForm()
                    }
                }
            }
        }
    }
    
    private func clearForm() {
        self.email = ""
        self.password = ""
    }
}

#Preview {
    LoginView()
}
