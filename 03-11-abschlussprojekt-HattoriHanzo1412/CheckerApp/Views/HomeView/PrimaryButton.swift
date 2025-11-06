


import SwiftUI
import Foundation

struct PrimaryButton: View {
    let title: String
    let disabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(disabled ? .gray : .blue)
                .cornerRadius(12)
        }
        .disabled(disabled)
    }
}
