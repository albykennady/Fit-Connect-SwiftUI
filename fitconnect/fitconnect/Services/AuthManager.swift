//
//  AuthManager.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 28/03/25.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    // Function to handle login
    func login(username: String, password: String, completion: @escaping (Result<Void, APIError>) -> Void) {
        // Your login request URL and parameters
        guard let url = URL(string: "\(APIConstants.baseURL)/login") else {
            completion(.failure(.invalidURL(description: "Failed to create URL for the login endpoint with base URL: \(APIConstants.baseURL)")))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create the login request body
        let body: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(description: "Network request failed with error: \(error.localizedDescription)")))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed(description: "No data received from the server")))
                return
            }

            do {
                // Assuming the response contains an "access_token"
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let accessToken = jsonResponse?["access_token"] as? String {
                    // Store the access token securely in Keychain
                    KeychainHelper.save(key: "accessToken", value: accessToken)
                    completion(.success(()))
                } else {
                    completion(.failure(.decodingFailed(description: "Failed to decode the response data")))
                }
            } catch {
                completion(.failure(.decodingFailed(description: "Failed to decode the response data")))
            }
        }.resume()
    }
}
