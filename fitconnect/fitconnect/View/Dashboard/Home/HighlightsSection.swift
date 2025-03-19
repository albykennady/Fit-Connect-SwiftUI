import SwiftUI

struct HighlightsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(Translations.LABEL_HIGHLIGHTS)
                .font(.title)
                .bold()

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                ForEach(highlightData) { item in
                    HighlightCard(highlight: item)
                }
            }
            
        }
    }
}

#Preview {
    HighlightsSection()
}
