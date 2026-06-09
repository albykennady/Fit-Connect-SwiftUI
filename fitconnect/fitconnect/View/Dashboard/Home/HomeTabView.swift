//
//  HomePageView.swift
//  FitConnect
//
//  Created by Alby Kennady on 20/02/25.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        DashboardHeaderView()
                        
                        HealthScoreView(score: 80)
                        
                        HighlightsSection()
                        
                        Spacer()
                        
                        ThisWeekReport()
                        
                        
                        
                        
                        
                    }
                    .padding()
                }
                .navigationBarHidden(true)
            }
}


#Preview {
    HomeTabView()
}
