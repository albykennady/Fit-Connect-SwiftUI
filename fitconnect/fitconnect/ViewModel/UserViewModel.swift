//
//  UserViewModel.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String? = nil
    
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchUsers() {
        apiService.fetchUsers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
