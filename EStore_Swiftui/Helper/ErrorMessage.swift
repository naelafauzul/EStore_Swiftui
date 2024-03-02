//
//  ErrorMessage.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 29/02/24.
//

import Foundation

struct ErrorMessage {
    static func message(for error: Error) -> String {
        switch error {
        case let URLError as URLError:
            return message(for: URLError)
        default:
            return FailedMessage.unexpected
        }
    }
    
    private static func message(for urlError: URLError) -> String {
        switch urlError.code {
        case .notConnectedToInternet:
            return FailedMessage.nonConnectedToInternet
            
        case .timedOut:
            return FailedMessage.timeout
            
        default:
            return FailedMessage.unexpected
        }
    }
}
