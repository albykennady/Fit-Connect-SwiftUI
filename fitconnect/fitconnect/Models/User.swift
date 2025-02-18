//
//  User.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String

    private enum CodingKeys: String, CodingKey {
        case id, name, email
    }
}

