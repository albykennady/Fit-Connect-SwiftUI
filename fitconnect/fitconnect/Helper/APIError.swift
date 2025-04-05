enum APIError: Error, Decodable, Encodable {
    case invalidURL(description: String)
    case requestFailed(description: String, message: String? = nil)
    case decodingFailed(description: String)
    case unauthorized(statusCode: Int)
    case missingRefreshToken(description: String)
    case unknownError(description: String)
    case encodingFailed(description: String)
    case serverError(description: String, message: String? = nil)
    case castError(description: String)

    // Decoding custom error responses
    enum CodingKeys: String, CodingKey {
        case description = "message"
        case statusCode = "status"
        case errorType = "error_type"
    }

    // Custom decoding logic
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Check for common 'message' key for the error description
        if let message = try? container.decode(String.self, forKey: .description) {
            // Try to detect more specific error cases based on keys in the response
            if let errorType = try? container.decode(String.self, forKey: .errorType) {
                switch errorType {
                case "unauthorized":
                    let statusCode = try container.decode(Int.self, forKey: .statusCode)
                    self = .unauthorized(statusCode: statusCode)
                case "serverError":
                    let statusCode = try container.decode(Int.self, forKey: .statusCode)
                    self = .serverError(description: message, message: "Server Error: \(message)")
                default:
                    self = .requestFailed(description: message, message: message)
                }
            } else {
                self = .requestFailed(description: message, message: message)
            }
        } else {
            self = .decodingFailed(description: "Failed to decode error message")
        }
    }

    // Encoding logic for Encodable conformance
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .invalidURL(let description):
            try container.encode(description, forKey: .description)
        case .requestFailed(let description, let message):
            try container.encode(description, forKey: .description)
            if let message = message {
                try container.encode(message, forKey: .description)
            }
        case .decodingFailed(let description):
            try container.encode(description, forKey: .description)
        case .unauthorized(let statusCode):
            try container.encode(statusCode, forKey: .statusCode)
        case .missingRefreshToken(let description):
            try container.encode(description, forKey: .description)
        case .unknownError(let description):
            try container.encode(description, forKey: .description)
        case .encodingFailed(let description):
            try container.encode(description, forKey: .description)
        case .serverError(let description, let message):
            try container.encode(description, forKey: .description)
            if let message = message {
                try container.encode(message, forKey: .description)
            }
        case .castError(let description):
            try container.encode(description, forKey: .description)
        }
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
        case .castError(let description):
            return "Casting Failed: \(description)"
        }
    }
}

