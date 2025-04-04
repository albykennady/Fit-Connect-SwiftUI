import Foundation

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

    // This is required for the Encodable conformance
    enum CodingKeys: String, CodingKey {
        case data, httpStatusCode, httpMessage, message
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
