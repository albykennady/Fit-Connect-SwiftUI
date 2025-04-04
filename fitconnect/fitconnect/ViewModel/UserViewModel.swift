//
//  UserViewModel.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false // Track loading state for fetching users
    @Published var isRegistering: Bool = false // Track loading state for user registration
    @Published var registrationMessage: String? = nil // Message after successful registration
    
    private let apiService: APIServiceProtocol
    
    // Initialize with the API service dependency
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    // Fetch the list of users
    func fetchUsers() {
        Logger.log("Fetching users started.") // Log the start of fetching users
        isLoading = true // Start loading
        apiService.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false // Stop loading
                switch result {
                case .success(let users):
                    Logger.log("Fetched users successfully.") // Log success
                    self.users = users
                case .failure(let error):
                    Logger.log("Failed to fetch users: \(error.localizedDescription)") // Log failure
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // Register a new user
    func registerUser(user: User, completion: @escaping (Result<APIResponse<User>, APIError>) -> Void) {
        Logger.log("Registration started for user: \(user.username)") // Log the start of registration
        isRegistering = true
        registrationMessage = nil
        errorMessage = nil

        apiService.registerUser(user: user) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isRegistering = false

                switch result {
                case .success(let response):
                    Logger.log("HTTP Status Code: \(response.httpStatusCode ?? 0)") // Log status code

                    // If the response has a message, log it
                    if let apiMessage = response.message {
                        Logger.log("API Response Message: \(apiMessage)")
                    }

                    // Check the status code and act accordingly
                    if let statusCode = response.httpStatusCode, statusCode == 200 {
                        // Check if the response.data contains another APIResponse<User>
                        if let nestedResponse = response.data as? APIResponse<User> {
                            // Registration successful with unwrapped data
                            Logger.log("Registration successful for user: \(user.username). Message: \(response.message ?? "No message")")
                            self.registrationMessage = response.message  // Use the message for feedback
                            completion(.success(nestedResponse))  // Pass the inner response (APIResponse<User>)
                        } else {
                            // Handle unexpected response format
                            let errorMessage = "Unexpected response format: Data is not an APIResponse<User>"
                            Logger.log("Registration failed for user: \(user.username). Error: \(errorMessage)")
                            self.errorMessage = errorMessage
                            completion(.failure(.requestFailed(description: errorMessage, message: errorMessage)))  // Pass failure
                        }
                    } else {
                        // Handle failure case
                        let errorMessage = response.message ?? "Unknown error"
                        Logger.log("Registration failed for user: \(user.username). Status code: \(response.httpStatusCode ?? 0). Message: \(errorMessage)")
                        self.errorMessage = errorMessage
                        completion(.failure(.requestFailed(description: "Registration failed with status code: \(response.httpStatusCode ?? 0)", message: errorMessage)))  // Pass failure
                    }

                case .failure(let error):
                    // Handle failure case
                    Logger.log("Registration failed for user: \(user.username). Error: \(error.localizedDescription)")
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    completion(.failure(error))  // Pass failure with the error returned
                }
            }
        }
    }


        
        
        
    }
    
    

