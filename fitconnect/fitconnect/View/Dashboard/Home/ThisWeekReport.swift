//
//  ThisWeekReport.swift
//  fitconnect
//
//  Created by Alby Kennady on 20/03/25.
//

import SwiftUI

struct ThisWeekReport: View {
    let highlights = WeeklyReportData.highlights

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(Translations.LABEL_TS_WK_RPRT)
                    .font(.system(size: 18, weight: .bold))

                Spacer()

                Button(action: {
                    // Action for "View More"
                }) {
                    HStack(spacing: 4) {
                        Text(Translations.LABEL_VIEW_MORE)
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                    }
                }
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                ForEach(highlights) { highlight in
                    WeeklyReportCard(highlight: highlight)
                }
            }
        }
        .padding()
    }
}

struct ThisWeekReport_Previews: PreviewProvider {
    static var previews: some View {
        ThisWeekReport()
            .previewLayout(.sizeThatFits)
            .padding()
            
    }
}
