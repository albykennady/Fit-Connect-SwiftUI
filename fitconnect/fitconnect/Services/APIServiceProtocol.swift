//
//  APIServiceProtocol.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 06/03/25.
//

import Foundation

protocol APIServiceProtocol {
    
    func fetchUsers(completion: @escaping (Result<[User], APIError>) -> Void)
    func registerUser(user: User, completion: @escaping (Result<APIResponse<String>, APIError>) -> Void)
}


