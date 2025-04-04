import Foundation

final class APIService: APIServiceProtocol {
    private let networkManager: NetworkManager
    private let baseURL: String

    init(networkManager: NetworkManager = .shared, baseURL: String = APIConstants.baseURL) {
        self.networkManager = networkManager
        self.baseURL = baseURL
    }

    // Fetch the list of users
    func fetchUsers(completion: @escaping (Result<[User], APIError>) -> Void) {
        let endpoint = "/users"
        networkManager.makeRequest(endpoint: endpoint, method: .get) { (result: Result<[User], APIError>) in
            completion(result)
        }
    }

    // Register a new user
    func registerUser(user: User, completion: @escaping (Result<APIResponse<User>, APIError>) -> Void) {
        let endpoint = APIConstants.USER_SIGNUP_END_POINT
        
        // Step 4: Making the network request
        networkManager.makeRequest(endpoint: endpoint, method: .post, body: user) { (result: Result<APIResponse<User>, APIError>) in
            switch result {
            case .success(let response):
                // Log the HTTP status code
                Logger.log("APIService - HTTP Status Code: \(response.httpStatusCode ?? 0)")

                // Check if the response contains a message and log it
                if let apiMessage = response.message {
                    Logger.log("APIService - API Response Message: \(apiMessage)")
                } else if let httpMessage = response.httpMessage {
                    Logger.log("APIService - HTTP Message: \(httpMessage)")
                }

                // If status code is 200, registration was successful
                if let statusCode = response.httpStatusCode, statusCode == 200 {
                    Logger.log("APIService - Registration successful for user: \(user.username). Message: \(response.httpMessage ?? "No message")")
                    completion(.success(response))  // Pass success response
                } else {
                    // Registration failed, pass failure with API message if available
                    Logger.log("APIService - Registration failed for user: \(user.username). Status code: \(response.httpStatusCode ?? 0). Message: \(response.message ?? "Unknown error")")
                    let errorMessage = response.message ?? "Unknown error"
                    
                    // Passing failure with detailed error
                    completion(.failure(.requestFailed(description: "Registration failed with status code: \(response.httpStatusCode ?? 0)", message: errorMessage)))
                }

            case .failure(let error):
                // Log the error details
                Logger.log("APIService - Error occurred: \(error.localizedDescription)")

                // If the error is an APIError, check for message
                if let apiResponse = error as? APIError {
                    switch apiResponse {
                    case .requestFailed(let description, let message):
                        Logger.log("APIService - Request failed with message: \(message) and description: \(description)")
                    case .castError:
                        Logger.log("APIService - Failed to cast the response to the expected type.")
                    default:
                        Logger.log("APIService - Other error occurred: \(apiResponse.localizedDescription)")
                    }
                }

                // Pass the error to the completion handler
                completion(.failure(error))
            }
        }
    }





}
