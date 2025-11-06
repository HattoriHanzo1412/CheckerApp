


import SwiftUI

struct LoadingIndicator: View {
    let text: String

    var body: some View {
        ProgressView(text)
            .padding()
    }
}
