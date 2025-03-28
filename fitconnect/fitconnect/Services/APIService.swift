//
//  APIService.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import Foundation

final class APIService: APIServiceProtocol {
    private let networkManager: NetworkManager
    private let baseURL: String

    init(networkManager: NetworkManager = .shared, baseURL: String = APIConstants.baseURL) {
        self.networkManager = networkManager
        self.baseURL = baseURL
    }

    func fetchUsers(completion: @escaping (Result<[User], APIError>) -> Void) {
        let endpoint = "/users"
        networkManager.makeRequest(endpoint: endpoint, method: .get) { (result: Result<[User], APIError>) in
            completion(result)
        }
    }
}



