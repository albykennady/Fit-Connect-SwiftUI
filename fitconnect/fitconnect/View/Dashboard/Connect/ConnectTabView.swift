//
//  ConnectTabView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import SwiftUICore
import SwiftUI

struct ConnectTabView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Connect Screen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // Your connect screen content goes here
            }
            .navigationTitle("Connect")
        }
    }
}
