//
//  DashboardScreenView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import SwiftUICore
import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        TabView {
            // Home Tab
            HomeTabView()
                .tabItem {
                    Image(systemName: "house.fill") // House icon for Home
                    Text("Home")
                }

            // Connect Tab
            ConnectTabView()
                .tabItem {
                    Image(systemName: "link.circle.fill") // Link icon for Connect
                    Text("Connect")
                }

            // Workout Tab
            WorkoutTabView()
                .tabItem {
                    Image(systemName: "figure.walk.circle.fill") // Workout icon
                    Text("Workout")
                }

            // User Tab
            UserTabView()
                .tabItem {
                    Image(systemName: "person.circle.fill") // Person icon for User
                    Text("User")
                }
        }
        .accentColor(.blue) // Customize the tab item color
    }
}
