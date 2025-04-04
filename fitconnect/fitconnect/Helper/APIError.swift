enum APIError: Error, Decodable {
    case invalidURL(description: String)
    case requestFailed(description: String, message: String? = nil)
    case decodingFailed(description: String)
    case unauthorized(statusCode: Int)
    case missingRefreshToken(description: String)
    case unknownError(description: String)
    case encodingFailed(description: String)
    case serverError(description: String, message: String? = nil)
    case castError(description: String)  // New castError case

    // Decoding custom error responses
    enum CodingKeys: String, CodingKey {
        case description = "message" // Mapping API error message to description
    }

    // Handle custom decoding logic here
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let message = try container.decode(String.self, forKey: .description)

        // You can modify the behavior to handle different cases accordingly
        self = .requestFailed(description: message, message: message)
    }

    // Provide a method to get a user-friendly error message
    var localizedDescription: String {
        switch self {
        case .invalidURL(let description):
            return "Invalid URL: \(description)"
        case .requestFailed(let description, let message):
            return message ?? "Request Failed: \(description)"
        case .decodingFailed(let description):
            return "Decoding Failed: \(description)"
        case .unauthorized(let statusCode):
            return "Unauthorized: HTTP status code \(statusCode)"
        case .missingRefreshToken(let description):
            return "Missing Refresh Token: \(description)"
        case .unknownError(let description):
            return "Unknown Error: \(description)"
        case .encodingFailed(let description):
            return "Encoding Failed: \(description)"
        case .serverError(let description, let message):
            return message ?? "Server Error: \(description)"
        case .castError(let description):  // Return a message for castError
            return "Casting Failed: \(description)"
        }
    }
}
