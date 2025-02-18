//
//  UserListView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//


import SwiftUI

struct UserListScreenView: View {
    @StateObject private var viewModel = UserViewModel()
    
    
    var body: some View {
       
        VStack {
            Text("User List")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            List(viewModel.users) { user in
                UserRowView(user: user)
            }
        }
        .onAppear {
            viewModel.fetchUsers()
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
        }
    }
}

#Preview {
    UserListScreenView()
}
