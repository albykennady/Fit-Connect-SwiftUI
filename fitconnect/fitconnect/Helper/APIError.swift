//
//  APIError.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 28/03/25.
//

// APIError.swift
enum APIError: Error {
    case invalidURL(description: String)  // Add description for invalid URL error
    case requestFailed(description: String)  // Add description for request failures
    case decodingFailed(description: String)  // Add description for decoding failures
    case unauthorized(statusCode: Int)  // Include statusCode to specify the error (e.g., 401)
    case missingRefreshToken(description: String)  // Add description for missing refresh token errors
    case unknownError(description: String)  // Add description for unknown errors
    
    // Provide a method to get a user-friendly error message
    var localizedDescription: String {
        switch self {
        case .invalidURL(let description):
            return "Invalid URL: \(description)"
        case .requestFailed(let description):
            return "Request Failed: \(description)"
        case .decodingFailed(let description):
            return "Decoding Failed: \(description)"
        case .unauthorized(let statusCode):
            return "Unauthorized: HTTP status code \(statusCode)"
        case .missingRefreshToken(let description):
            return "Missing Refresh Token: \(description)"
        case .unknownError(let description):
            return "Unknown Error: \(description)"
        }
    }
}

