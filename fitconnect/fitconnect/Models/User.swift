//
//  User.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import Foundation

struct User:  Codable {
    let username: String
    let password: String
    let email: String
    let roles: [String]

    private enum CodingKeys: String, CodingKey {
        case  username, password, email, roles
    }
}


