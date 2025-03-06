//
//  APIError.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//
import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case requestFailed
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The API URL is invalid."
        case .requestFailed:
            return "Failed to complete the request."
        case .decodingFailed:
            return "Failed to decode the response."
        }
    }
}


