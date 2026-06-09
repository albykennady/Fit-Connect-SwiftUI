//
//  HighlightCard.swift
//  fitconnect
//
//  Created by Alby Kennady on 19/03/25.
//

import SwiftUI

struct HighlightCard: View {
    let highlight: Highlight

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                Image(systemName: highlight.icon)
                    .font(.system(size: 50))
                    .foregroundColor(.white)

                
            }

            Text(highlight.title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white.opacity(0.9))

            Text(highlight.value)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)

            Text(highlight.timestamp)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .frame(width: 175, height: 201)
        .background(highlight.color)
        .cornerRadius(20) 
    }
}
    
struct HighlightCard_Previews: PreviewProvider {
    static var previews: some View {
        HighlightCard(highlight: Highlight(
            title: Translations.LABEL_CAL_BURNED,
            icon: "flame.fill",
            value: "320 kcal",
            color: Color.orange,
            timestamp: Translations.LABEL_UPDT_TIME
            
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
