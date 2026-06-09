
//
//  HealthData.swift
//  FitConnect
//
//  Created by Alby Kennady on 20/03/25.
//

import SwiftUI

struct HealthDataItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let unit: String
    let imageName: String  // Custom image name
    let backgroundColor: Color
}
