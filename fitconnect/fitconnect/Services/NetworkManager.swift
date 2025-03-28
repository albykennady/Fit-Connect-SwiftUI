//
//  NetworkManager.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 28/03/25.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let urlSession: URLSession
    private let baseURL: String

    private init(urlSession: URLSession = .shared, baseURL: String = APIConstants.baseURL) {
        self.urlSession = urlSession
        self.baseURL = baseURL
    }

    func makeRequest<T: Decodable>(endpoint: String, method: HTTPMethod = .get, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(.invalidURL(description: "Failed to create URL from baseURL and endpoint")))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Add the access token to the Authorization header
        if let accessToken = getStoredAccessToken() {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        urlSession.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(description: "Network request failed with error: \(error.localizedDescription)")))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed(description: "No data received from the server")))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                // Token expired, attempt to refresh the token
                self?.refreshAccessToken { result in
                    switch result {
                    case .success(let newAccessToken):
                        // Retry the original request with the new access token
                        self?.retryRequestWithNewToken(request: request, newAccessToken: newAccessToken, completion: completion)
                    case .failure:
                        completion(.failure(.unauthorized(statusCode: 401)))
                    }
                }
            } else {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch {
                    completion(.failure(.decodingFailed(description: "Failed to decode the response")))
                }
            }
        }.resume()
    }

    func refreshAccessToken(completion: @escaping (Result<String, APIError>) -> Void) {
        guard let refreshToken = getStoredRefreshToken() else {
            completion(.failure(.missingRefreshToken(description: "No refresh token found in storage")))
            return
        }

        guard let url = URL(string: "\(baseURL)/refresh-token") else {
            completion(.failure(.invalidURL(description: "Invalid URL for refresh token endpoint")))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["refresh_token": refreshToken]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        urlSession.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(.requestFailed(description: "Request to refresh token failed with error: \(error.localizedDescription)")))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed(description: "No data received from refresh token request")))
                return
            }

            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let newAccessToken = jsonResponse?["access_token"] as? String {
                    self.storeNewAccessToken(newAccessToken)
                    completion(.success(newAccessToken))
                } else {
                    completion(.failure(.decodingFailed(description: "Failed to decode refresh token response")))
                }
            } catch {
                completion(.failure(.decodingFailed(description: "Error decoding the refresh token response")))
            }
        }.resume()
    }

    // MARK: - Helper Functions

    // Get the stored access token (retrieve from UserDefaults or secure storage like Keychain)
    func getStoredAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }

    // Get the stored refresh token (retrieve from UserDefaults or secure storage like Keychain)
    func getStoredRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }

    // Store the new access token securely (e.g., in UserDefaults or Keychain)
    func storeNewAccessToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }

    // Retry the original request with the new access token
    func retryRequestWithNewToken<T: Decodable>(request: URLRequest, newAccessToken: String, completion: @escaping (Result<T, APIError>) -> Void) {
        var modifiedRequest = request
        modifiedRequest.setValue("Bearer \(newAccessToken)", forHTTPHeaderField: "Authorization")

        urlSession.dataTask(with: modifiedRequest) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(description: "Network request failed with error: \(error.localizedDescription)")))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed(description: "No data received from the server")))
                return
            }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                completion(.failure(.decodingFailed(description: "Failed to decode the response")))
            }
        }.resume()
    }
}


