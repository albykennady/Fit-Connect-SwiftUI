//
//  WeeklyReportCard.swift
//  fitconnect
//
//  Created by Alby Kennady on 19/03/25.
//

import SwiftUI

struct WeeklyReportCard: View {
    let highlight: Highlight

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: highlight.icon)
                    .font(.system(size: 24))
                    .foregroundColor(.black)

                Spacer()
            }

            Text(highlight.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)

            Text(highlight.value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)

            Text(highlight.timestamp)
                .font(.system(size: 12))
                .foregroundColor(.gray.opacity(0.8))
        }
        .padding()
        .frame(width: 170, height: 125)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct WeeklyReportCard_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyReportCard(highlight: WeeklyReportData.highlights[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
