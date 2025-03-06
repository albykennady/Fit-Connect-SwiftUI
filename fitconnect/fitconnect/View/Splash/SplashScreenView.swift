//
//  SplashScreenView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//
import SwiftUI

struct SplashScreenView: View {
    @State private var isLoggedIn = false
    @State private var showSplash = true
    
    var body: some View {
        VStack {
            Spacer()
            Text("FitConnect")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
        .onAppear {
            // Simulate a network delay for splash screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 5 seconds delay
                // Check if user is logged in (e.g., check user defaults, token, etc.)
                self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
                self.showSplash = false // Hide splash after delay
            }
        }
        .fullScreenCover(isPresented: $isLoggedIn, content: {
            // Navigate to User List screen if logged in
            HomeScreenView()
        })
        .fullScreenCover(isPresented: .constant(!isLoggedIn && !showSplash), content: {
            // Navigate to Intro Screen if not logged in
            IntroScreenView()
        })
    }
}



#Preview {
    SplashScreenView()
}

