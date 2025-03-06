//
//  APIService.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import Foundation

final class APIService: APIServiceProtocol {
    private let urlSession: URLSession
    private let baseURL: String

    init(urlSession: URLSession = .shared, baseURL: String = APIConstants.baseURL) {
        self.urlSession = urlSession
        self.baseURL = baseURL
    }

    func fetchUsers(completion: @escaping (Result<[User], APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users") else {
            completion(.failure(.invalidURL))
            return
        }

        urlSession.dataTask(with: url) { data, _, error in
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


