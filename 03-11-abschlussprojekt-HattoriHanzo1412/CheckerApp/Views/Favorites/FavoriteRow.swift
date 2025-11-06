


import SwiftUI

struct FavoriteRow: View {
    @Environment(\.openURL) private var openURL

    let check: URLCheck
    let toggle: () -> Void
    let delete: () -> Void

    var body: some View {
        let percent = Int(check.confidence * 100)
        let statusText = check.isPhish ? "Phish" : "Clean"
        let statusColor: Color = check.isPhish ? .red : .green

        HStack(spacing: 16) {
            Image(systemName: check.isPhish ? "exclamationmark.triangle.fill"
                                            : "checkmark.shield.fill")
                .foregroundColor(statusColor)
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

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(percent)%")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.tint)
                Text(statusText)
                    .font(.caption)
                    .foregroundColor(statusColor)
            }

            Button(action: toggle) {
                Image(systemName: check.isFavorite ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(check.isFavorite ? "Remove from favorites" : "Add to favorites")
        }
        .padding(.vertical, 7)
        .contentShape(Rectangle())
        .onTapGesture(perform: toggle)
        .contextMenu {
            if let url = URL(string: check.url) {
                Button { openURL(url) } label: {
                    Label("Open", systemImage: "safari")
                }
                ShareLink(item: url) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
            Divider()
            Button(role: .destructive, action: delete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
