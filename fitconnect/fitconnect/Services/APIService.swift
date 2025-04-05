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

    
    
    func registerUser(user: User, completion: @escaping (Result<APIResponse<String>, APIError>) -> Void) {
       
        let endpoint = APIConstants.USER_SIGNUP_END_POINT

        networkManager.makeRequest(endpoint: endpoint, method: .post, body: user) { (result: Result<APIResponse<String>, APIError>) in
            Logger.log("")
            Logger.log("APIService - Result of Registration \(result)")

            switch result {
            case .success(let response):
                Logger.log("APIService - HTTP Status Code: \(response.httpStatusCode ?? 0)")
                if let apiMessage = response.message {
                    Logger.log("APIService - API Response Message: \(apiMessage)")
                }

                if let statusCode = response.httpStatusCode, statusCode == 200 {
                    Logger.log("APIService - Registration successful for user: \(user.username). Message: \(response.message ?? "No message")")
                    completion(.success(response))  // Pass success response
                } else {
                    Logger.log("APIService - Registration failed for user: \(user.username). Status code: \(response.httpStatusCode ?? 0). Message: \(response.message ?? "Unknown error")")
                    let errorMessage = response.message ?? "Unknown error"
                    completion(.failure(.requestFailed(description: "Registration failed with status code: \(response.httpStatusCode ?? 0)", message: errorMessage)))
                }

            case .failure(let error):
                Logger.log("APIService - Error occurred: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }





    // A helper method to serialize the result into JSON string for logging
    private func serializeToJSON(result: Result<APIResponse<String>, APIError>) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Format for better readability
        
        do {
            let jsonData: Data
            switch result {
            case .success(let response):
                jsonData = try encoder.encode(response)
            case .failure(let error):
                jsonData = try encoder.encode(error)  // Encode the error object
            }
            
            // Convert the data to a pretty-printed JSON string
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            Logger.log("Failed to serialize result to JSON: \(error.localizedDescription)")
            return nil
        }
    }

}
