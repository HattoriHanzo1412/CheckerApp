


import SwiftUI

struct ErrorBanner: View {
    let message: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "xmark.octagon.fill")
                .foregroundColor(.red)
            Text(message)
                .foregroundColor(.red)
                .font(.headline)
            Spacer(minLength: 0)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.red.opacity(0.08))
        .cornerRadius(12)
    }
}
