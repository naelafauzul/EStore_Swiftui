//
//  PhotoSource.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 02/03/24.
//

import Foundation

enum PhotoSource: Identifiable {
    case photoLibrary
    case camera
    
    var id: Int {
        hashValue
    }
    
//    var id: String {
//        switch self {
//        case .photoLibrary:
//            return "photoLibrary"
//        case .camera:
//            return "camera"
//        }
//    }
}
