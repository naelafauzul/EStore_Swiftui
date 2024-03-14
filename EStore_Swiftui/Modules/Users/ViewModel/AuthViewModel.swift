//
//  AuthViewModel.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 27/02/24.
//

import SwiftUI
import KeychainSwift

@MainActor
class AuthViewModel: ObservableObject {
    @Published var message: String?
    @Published var isRegistrationSuccess: Bool = false
    @Published var isLoggedIn: Bool = false
    
    private let keychain = KeychainSwift()
    
    // MARK: - REGISTER VM
    func registerUser(name: String, email: String, password: String, avatar: String) async {
        let user = User(id: nil, email: email, password: password, name: name, avatar: avatar, role: nil)
        
        do {
            let registeredUser = try await AuthService.shared.createUser(with: user)
            let successRegister = """
                {
                    "status": "Success",
                    "message": "User successfully registered",
                    "user": {
                        "id": "\(String(describing: registeredUser.id))",
                        "name": "\(registeredUser.name)",
                        "email": "\(registeredUser.email)",
                        "avatar": "\(registeredUser.avatar)"
                    }
                }
            """
            print(successRegister)
            
            let userID = registeredUser.id ?? 1
            self.message = "User successfully registered with ID: \(userID))"
            
            self.isRegistrationSuccess = true
        } catch {
            let errorRegistration = """
            {
                "status": "error",
                "message": "Failed to register user: \(error.localizedDescription)"
            }
            """
            print(errorRegistration)
            
            self.message = "Failed to register user: \(error.localizedDescription)"
            self.isRegistrationSuccess = false
        }
    }
}

//// MARK: - LOGIN VM
//extension AuthViewModel {
//    func login(email: String, password: String) async {
//        do {
//            let response = try await AuthService.shared.login(email: email, password: password)
//            // Simpan accessToken dan refreshToken sesuai kebutuhan, misalnya di UserDefaults atau Keychain
//            keychain.set(response.accessToken, forKey: "accessToken")
//            keychain.set(response.refreshToken, forKey: "refreshToken")
//
//            print("Login berhasil, accessToken: \(response.accessToken)")
//            print("Login berhasil, refreshToken: \(response.refreshToken)")
//
//            isLoggedIn = true
//        } catch {
//            // self.message = ErrorMessage.message(for: error)
//            self.message = error.localizedDescription
//            let errorDebug = """
//            {
//                "message": \(message ?? ErrorMessage.message(for: error)),
//                "statusCode": 401
//            }
//            """
//            print(errorDebug)
//            isLoggedIn = false
//        }
//    }
//
//    func logout() {
//        // Hapus token dari Keychain saat logout
//        keychain.delete("accessToken")
//        keychain.delete("refreshToken")
//
//        // Update state aplikasi
//        isLoggedIn = false
//    }
//}

// MARK: - LOGIN VM
extension AuthViewModel {
    func login(email: String, password: String) async {
        do {
            let response = try await AuthService.shared.login(email: email, password: password)
            
            // Simpan accessToken dan refreshToken
            keychain.set(response.accessToken, forKey: "accessToken")
            keychain.set(response.refreshToken, forKey: "refreshToken")
            
            print("Login berhasil, accessToken: \(response.accessToken)")
            print("Login berhasil, refreshToken: \(response.refreshToken)")
            
            isLoggedIn = true
        } catch let error as NetworkError {
            // Menggunakan ErrorMessage untuk mendapatkan pesan error yang spesifik dan informatif
            self.message = error.localizedDescription
            printErrorDebug(error: error)
            isLoggedIn = false
        } catch {
            // Fallback untuk error yang tidak dikenal
            self.message = "An unexpected error occurred."
            printErrorDebug(error: error)
            isLoggedIn = false
        }
    }
    
    private func printErrorDebug(error: Error) {
        var errorMessage: String = "Unknown error"
        var statusCode: Int = -1 // Gunakan -1 atau nilai lain sebagai indikator "unknown"
        
        if let networkError = error as? NetworkError {
            errorMessage = networkError.localizedDescription
            switch networkError {
            case .unauthorized(let message, let code):
                errorMessage = message
                statusCode = code
            default:
                break
            }
        }
        
        let errorDebug = """
        {
            "message": "\(errorMessage)",
            "statusCode": \(statusCode)
        }
        """
        print(errorDebug)
    }
    
    func logout() {
        // Hapus token dari Keychain saat logout
        keychain.delete("accessToken")
        keychain.delete("refreshToken")
        
        // Update state aplikasi
        isLoggedIn = false
        
    }
}
    
