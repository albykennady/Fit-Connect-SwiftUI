//
//  APIService.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import Foundation

import Foundation

protocol APIServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], APIError>) -> Void)
}

class APIService: APIServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], APIError>) -> Void) {
        let urlString = "\(APIConstants.baseURL)/users"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(users))
                }
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}


