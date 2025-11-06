

import SwiftUI

struct StatusBanner: View {
    let message: String
    let isSafe: Bool

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: isSafe ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                .foregroundColor(isSafe ? .green : .red)
            Text(message)
                .font(.headline)
                .foregroundColor(isSafe ? .green : .red)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background((isSafe ? Color.green : Color.red).opacity(0.08))
        .cornerRadius(12)
    }
}
