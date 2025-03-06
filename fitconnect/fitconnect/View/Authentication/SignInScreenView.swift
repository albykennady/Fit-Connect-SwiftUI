//
//  SignInScreenView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//
import SwiftUI

struct SignInScreenView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false // State variable to control navigation
    
    var body: some View {
        NavigationStack {
            VStack {
                
                
                Text("Sign In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Username", text: $username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    // Handle login logic here, then navigate to User List screen
                    // Example: After successful login, set isLoggedIn to true
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    isLoggedIn = true // This triggers the navigation
                }) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // NavigationLink that is activated when isLoggedIn becomes true
                NavigationLink(destination: HomeScreenView(), isActive: $isLoggedIn) {
                    EmptyView() // Invisible, triggers navigation when isLoggedIn is true
                }
            }
            .padding()
        }
    }
}

#Preview {
    SignInScreenView()
}

