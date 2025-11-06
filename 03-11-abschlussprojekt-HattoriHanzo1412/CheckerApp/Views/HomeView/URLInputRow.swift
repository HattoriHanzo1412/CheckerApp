


import SwiftUI

struct URLInputRow: View {
    @Binding var text: String
    var placeholder: String
    var onSubmit: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "link")
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.go)
                .onSubmit { onSubmit() }
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}
