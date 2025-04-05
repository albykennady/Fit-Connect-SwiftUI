struct APIResponse<T: Decodable & Encodable>: Decodable, Encodable {
    var data: T?
    var httpStatusCode: Int?
    var httpMessage: String?
    var message: String?

    // Initializer for creating an instance of APIResponse
    init(data: T? = nil, httpStatusCode: Int? = nil, httpMessage: String? = nil, message: String? = nil) {
        self.data = data
        self.httpStatusCode = httpStatusCode
        self.httpMessage = httpMessage
        self.message = message
    }

    // Decoding function to handle both data and message responses
    enum CodingKeys: String, CodingKey {
        case data
        case httpStatusCode
        case httpMessage
        case message
    }

    // Custom decoding to handle different types of responses (message vs. data)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Try decoding each key (with error handling)
        self.data = try? container.decode(T.self, forKey: .data)
        self.httpStatusCode = try? container.decode(Int.self, forKey: .httpStatusCode)
        self.httpMessage = try? container.decode(String.self, forKey: .httpMessage)
        self.message = try? container.decode(String.self, forKey: .message)

        // Handle edge case where only message is returned (i.e., no actual data)
        if self.data == nil && self.message != nil {
            self.data = nil // No data, just a message
        }
    }

    // Encoding function to convert the object to JSON format
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode each property if it has a value
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(httpStatusCode, forKey: .httpStatusCode)
        try container.encodeIfPresent(httpMessage, forKey: .httpMessage)
        try container.encodeIfPresent(message, forKey: .message)
    }
}

