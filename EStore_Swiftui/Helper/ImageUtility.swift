//
//  ImageUtility.swift
//  EStore_Swiftui
//
//  Created by Naela Fauzul Muna on 14/03/24.
//

import Foundation

struct ImageUtility {

    /// Extracts the first URL from a JSON string array or tries to create a URL directly from the input string.
    /// - Parameter string: A string that might contain a JSON array of URLs or a single URL.
    /// - Returns: An optional `URL`. Returns `nil` if no valid URL could be extracted.
    static func extractImageUrl(from string: String) -> URL? {
        // First, attempt to decode the string as a JSON array of URLs.
        if let urlFromJsonArray = extractFirstUrlFromJsonString(string) {
            return urlFromJsonArray
        }
        
        // If the above fails, try to interpret the string directly as a URL.
        return URL(string: string)
    }
    
    /// Attempts to decode a string as a JSON array of strings and extracts the first URL if available.
    /// - Parameter jsonString: The JSON string to decode.
    /// - Returns: An optional `URL` extracted from the first element of the array.
    private static func extractFirstUrlFromJsonString(_ jsonString: String) -> URL? {
        guard let data = jsonString.data(using: .utf8),
              let imageUrlArray = try? JSONDecoder().decode([String].self, from: data),
              let firstUrlString = imageUrlArray.first,
              let firstUrl = URL(string: firstUrlString) else {
            return nil
        }
        
        return firstUrl
    }
}
