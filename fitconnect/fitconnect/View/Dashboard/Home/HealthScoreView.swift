//
//  HealthScoreView.swift
//  FitConnect
//
//  Created by Alby Kennady on 19/03/25.
//

import SwiftUI

struct HealthScoreView: View {
    let score: Int

    var body: some View {
        VStack {
            HStack {
                Text(Translations.LABEL_OVERVIEW)
                    .font(.system(size: 30, weight: .bold))
                
                Spacer()
                
                NavigationLink(destination: AllHealthDataView()) {
                    HStack {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color(UIColor(red: 0.45, green: 0.87, blue: 0.78, alpha: 1.00)))
                        
                        Text("All data")
                            .foregroundColor(Color(UIColor(red: 0.45, green: 0.87, blue: 0.78, alpha: 1.00)))
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(UIColor(red: 0.45, green: 0.87, blue: 0.78, alpha: 1.00)), lineWidth: 1)
                    )
                }
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(Translations.LABEL_HLTH_SCR)
                        .font(.system(size: 20, weight: .heavy))
                    
                    Spacer()
                    
                    ZStack(alignment: .top) {
                        Image("scoreback")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .offset(y: -16)
                        
                        Text("\(score)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .offset(y: -17)
                    }
                    .frame(width: 78, height: 72, alignment: .top)
                }
                
                Text("Based on your overview health tracking,\nyour score is \(score) and is considered good.")
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                Text(Translations.BTN_TELL_ME_MORE)
                    .font(.caption)
                    .foregroundColor(.green)
            }
            .padding()
            .background(Color(UIColor(red: 0.94, green: 0.99, blue: 0.98, alpha: 1.00)))
            .cornerRadius(12)
        }
    }
}

#Preview {
    NavigationView { 
        HealthScoreView(score: 78)
    }
}
