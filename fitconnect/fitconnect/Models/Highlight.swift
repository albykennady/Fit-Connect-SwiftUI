//
//  Highlight.swift
//  fitconnect
//
//  Created by Alby Kennady on 19/03/25.
//
import Foundation
import SwiftUI

struct Highlight: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let value: String
    let color: Color
    let timestamp: String
}
