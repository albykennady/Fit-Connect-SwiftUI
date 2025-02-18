//
//  UserTabView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import SwiftUI

struct UserTabView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("User Screen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Add NavigationLink to navigate to User List Screen
                NavigationLink(destination: UserListScreenView()) {
                    Text("Go to User List")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("User")
        }
    }
}

#Preview {
    UserTabView()
}
