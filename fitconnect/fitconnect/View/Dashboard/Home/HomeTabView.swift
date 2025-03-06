//
//  HomeTabView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import SwiftUICore
import SwiftUI

struct HomeTabView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home Screen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                NavigationLink(destination: Text("Detail View")) {
                    Text("Go to Detail View")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Home")
        }
    }
}
