//
//  ContentView.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var avatar = "https://i.pravatar.cc/150?img=31"
    
    @StateObject private var createUserVM = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("User information").font(.headline)
                    
                    TextField("Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        registeredUser()
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(.borderedProminent)
                    
                   
                }
                .padding()
            }
            .navigationTitle(Constant.registerViewTitle)
            .alert(isPresented: $createUserVM.isRegistrationSuccess) {
                Alert(
                    title: Text("Registration"),
                    message: Text(createUserVM.message ?? "N/A"),
                    dismissButton: .default(Text("OK"), action: {
                        self.name = ""
                        self.email = ""
                        self.password = ""
                    })
                
                )
            }
        }
    }
    
    private func registeredUser() {
        Task {
            await createUserVM.registerUser(name: name, email: email, password: password, avatar: avatar)
        }
    }
}

#Preview {
    RegisterView()
}

