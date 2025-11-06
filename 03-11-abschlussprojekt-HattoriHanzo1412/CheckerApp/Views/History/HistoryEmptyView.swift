

import SwiftUI

struct HistoryEmptyView: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("History is empty")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("Check a link on the Home tab — it will appear here.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
    }
}
