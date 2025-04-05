//
//  HTTPMethod.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 28/03/25.
//

import Foundation

// Enum to define HTTP methods
/// Enum representing HTTP request methods.
enum HTTPMethod: String {
    
    /// Used to retrieve data from the server (safe and idempotent).
    case get = "GET"
    
    /// Used to send data to create a new resource (not idempotent).
    case post = "POST"
    
    /// Used to update an existing resource (idempotent).
    case put = "PUT"
    
    /// Used to delete a resource from the server (idempotent).
    case delete = "DELETE"
    
}

