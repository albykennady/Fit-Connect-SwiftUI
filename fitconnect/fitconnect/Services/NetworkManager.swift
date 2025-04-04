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

    
    
    
    func makeRequest<T: Decodable & Encodable>(endpoint: String, method: HTTPMethod = .get, body: Encodable? = nil, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            Logger.log("NetworkManager - Error: Failed to create URL from baseURL and endpoint")
            completion(.failure(.invalidURL(description: "Failed to create URL from baseURL and endpoint")))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Log the request URL
        Logger.log("NetworkManager - Request URL: \(url)")

        // Add the access token to the Authorization header if present
        if let accessToken = getStoredAccessToken() {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        // Log the headers
        Logger.log("NetworkManager - Request Headers: \(String(describing: request.allHTTPHeaderFields))")

        // Add body if method is POST or PUT, otherwise leave it nil
        if method == .post || method == .put {
            if let body = body {
                do {
                    let jsonData = try JSONEncoder().encode(body) // Encode the body as JSON
                    request.httpBody = jsonData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Set Content-Type header
                    
                    // Log the request body
                    if let bodyString = String(data: jsonData, encoding: .utf8) {
                        Logger.log("NetworkManager - Request Body: \(bodyString)")
                    }
                } catch {
                    Logger.log("NetworkManager - Error: Failed to encode body data")
                    completion(.failure(.encodingFailed(description: "Failed to encode body data")))
                    return
                }
            }
        }

        // Perform the network request
        urlSession.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                Logger.log("NetworkManager - Failure: Network request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed(description: "Network request failed with error: \(error.localizedDescription)")))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                Logger.log("NetworkManager - Failure: Invalid response")
                completion(.failure(.requestFailed(description: "Invalid response received from server")))
                return
            }

            // Log the HTTP status code
            let statusCode = httpResponse.statusCode
            Logger.log("NetworkManager - HTTP Status Code: \(statusCode)") // Log the HTTP status code
            
            // If status code is not within the 2xx range, handle it as failure
            if !(200...299).contains(statusCode) {
                let errorMessage = "Request failed with status code: \(statusCode)"
                Logger.log("NetworkManager - Failure: \(errorMessage)")
                completion(.failure(.requestFailed(description: errorMessage)))
                return
            }

            // If status code is 200 OK, process the response data
            if let data = data {
                do {
                    var apiResponse = try JSONDecoder().decode(APIResponse<T>.self, from: data)
                    
                    // Set the status code after decoding
                    apiResponse.httpStatusCode = statusCode  // Now that httpStatusCode is var, you can modify it
                    
                    Logger.log("NetworkManager - Response Data: \(apiResponse)") // Log the response data
                    
                    DispatchQueue.main.async {
                        guard let validResponse = apiResponse as? T else {
                            // Handle the error by passing a failure with an error that includes a message
                            completion(.failure(APIError.unknownError(description: "Failed to cast response.")))
                            return
                        }
                        completion(.success(validResponse)) // Pass the valid response
                    }

                } catch {
                    Logger.log("NetworkManager - Failure: Decoding failed with error: \(error.localizedDescription)")
                    completion(.failure(.decodingFailed(description: "Failed to decode the response")))
                }
            } else {
                Logger.log("NetworkManager - Failure: No data received from the server")
                completion(.failure(.requestFailed(description: "No data received from the server")))
            }
        }.resume()

        Logger.log("----------------LOG END NetworkManager-------------")
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


