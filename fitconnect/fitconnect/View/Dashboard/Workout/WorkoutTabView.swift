//
//  WorkoutTabView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//

import SwiftUICore
import SwiftUI

struct WorkoutTabView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Workout Screen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // Your workout screen content goes here
            }
            .navigationTitle("Workout")
        }
    }
}
