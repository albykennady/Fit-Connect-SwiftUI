//
//  AuthViewModel.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 28/03/25.
//
import Foundation
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    // Reference to AuthManager (service layer)
    private let authManager = AuthManager.shared
    
    // Login function that updates ViewModel properties
    func login(username: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        authManager.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success():
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.isAuthenticated = false
                }
            }
        }
    }
}

