//
//  HealthDataViewModel.swift
//  FitConnect
//
//  Created by Alby Kennady on 20/03/25.
//

import SwiftUI

class HealthDataViewModel: ObservableObject {
    @Published var healthData: [HealthDataItem] = []

    init() {
        fetchHealthData()
    }

    func fetchHealthData() {
        healthData = [
            HealthDataItem(title: "Double Support Time", value: "29.7", unit: "%", imageName: "double_support_time", backgroundColor: .mint),
            HealthDataItem(title: "Steps", value: "11,875", unit: "steps", imageName: "steps", backgroundColor: .purple),
            HealthDataItem(title: "Cycle Tracking", value: "08 April", unit: "", imageName: "cycle_tracking", backgroundColor: .pink),
            HealthDataItem(title: "Sleep", value: "7 hr 31 min", unit: "hours", imageName: "sleep", backgroundColor: .orange),
            HealthDataItem(title: "Heart", value: "68", unit: "BPM", imageName: "heart", backgroundColor: .red),
            HealthDataItem(title: "Burned Calories", value: "850", unit: "kcal", imageName: "burned_calories", backgroundColor: .teal),
            HealthDataItem(title: "Body Mass Index", value: "18.69", unit: "BMI", imageName: "bmi", backgroundColor: .blue)
        ]
    }
}
