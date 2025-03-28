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
    @Published var isLoading: Bool = false // ✅ Track loading state
    
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchUsers() {
        isLoading = true // ✅ Start loading
        apiService.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false // ✅ Stop loading
                switch result {
                case .success(let users):
                    self.users = users
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}



