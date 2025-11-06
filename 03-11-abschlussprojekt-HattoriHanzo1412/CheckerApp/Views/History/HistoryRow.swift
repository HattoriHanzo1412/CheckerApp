

import SwiftUI

struct HistoryRow: View {
    let check: URLCheck
    let toggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: check.isPhish ? "exclamationmark.triangle.fill"
                                            : "checkmark.shield.fill")
                .foregroundColor(check.isPhish ? .red : .green)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text(check.url)
                    .font(.headline)
                    .lineLimit(1)
                Text(check.time, style: .date)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }

            Spacer()

            Button(action: toggle) {
                Image(systemName: check.isFavorite ? "star.fill" : "star")
                    .foregroundStyle(check.isFavorite ? .yellow : .gray)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(check.isFavorite ? "Remove from favorites" : "Add to favorites")
        }
        .padding(.vertical, 6)
    }
}
