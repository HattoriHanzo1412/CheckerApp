

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel = URLCheckViewModel()
    @Environment(\.modelContext) private var modelContext

    @State private var shakeTrigger = 0
    @State private var dangerFlash = false

    var body: some View {
        NavigationStack {
            ZStack {
                content
                    .modifier(ShakeEffect(animatableData: CGFloat(shakeTrigger)))

                DangerFlashOverlay(show: dangerFlash)
                    .ignoresSafeArea()
                    .transition(.opacity)
            }
            .navigationTitle("Checking the link")
            .onChange(of: viewModel.lastIsSafe) { _, isSafe in
                guard let isSafe else { return }
                if !isSafe {
                    withAnimation(.easeInOut(duration: 0.35)) { dangerFlash = true }
                    shakeTrigger += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        dangerFlash = false
                    }
                }
            }
        }
    }

    private var content: some View {
        VStack(spacing: 24) {
            Text("PhishChecker")
                .font(.largeTitle.bold())
                .foregroundStyle(.blue)

            URLInputRow(
                text: $viewModel.urlString,
                placeholder: "Insert link (https://...)",
                onSubmit: runCheck
            )

            PrimaryButton(
                title: "Check link",
                disabled: isActionDisabled,
                action: runCheck
            )

            if viewModel.isLoading {
                LoadingIndicator(text: "Let's check...")
            }

            if let error = viewModel.error {
                ErrorBanner(message: error)
            }

            if let message = viewModel.message {
                StatusBanner(
                    message: message,
                    isSafe: (viewModel.lastIsSafe == true)
                )
            }

            Spacer()
        }
        .padding()
    }

    private var isActionDisabled: Bool {
        viewModel.isLoading ||
        viewModel.urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func runCheck() {
        Task { await viewModel.check(saveTo: modelContext) }
    }
}
