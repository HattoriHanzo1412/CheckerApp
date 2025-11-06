

import SwiftUI

struct EmptyFavoritesView: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "star.slash")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("It's empty here for now...")
                .foregroundColor(.secondary)
                .font(.headline)
            Text("Star posts in History and they'll appear here.")
                .foregroundColor(.secondary)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
    }
}
