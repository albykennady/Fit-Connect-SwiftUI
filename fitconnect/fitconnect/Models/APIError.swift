//
//  APIError.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//
import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .requestFailed: return "Request failed."
        case .decodingFailed: return "Failed to decode response."
        }
    }
}

