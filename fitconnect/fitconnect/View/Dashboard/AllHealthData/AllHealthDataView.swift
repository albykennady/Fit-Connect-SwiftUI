//
//  AllHealthDataView.swift
//  FitConnect
//
//  Created by Alby Kennady on 20/03/25.
//

import SwiftUI

struct AllHealthDataView: View {
    @StateObject private var viewModel = HealthDataViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text(Translations.TITLE_ALL_HLTH_DATA)
                    .font(.title2)
                    .padding(.top, 10)

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.healthData) { data in
                            HStack {
                                ZStack {
                                    Image(data.imageName)  // Custom image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 54, height: 54)
                                }

                                VStack(alignment: .leading) {
                                    Text(data.title)
                                        .font(.headline)
                                    Text("\(data.value) \(data.unit)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding()
                }
                Spacer()

            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    AllHealthDataView()
}
