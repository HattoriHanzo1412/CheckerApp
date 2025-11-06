


import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \URLCheck.time, order: .reverse)
    private var checks: [URLCheck]

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            Group {
                if checks.isEmpty {
                    HistoryEmptyView()
                } else {
                    List {
                        ForEach(checks) { item in
                            HistoryRow(
                                check: item,
                                toggle: { toggleFavorite(item) }
                            )
                            /// свайп только для удаления
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    delete(item: item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        /// для режима Edit (массовое удаление)
                        .onDelete(perform: deleteOffsets)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("History")
        }
    }


    private func toggleFavorite(_ check: URLCheck) {
        withAnimation {
            check.isFavorite.toggle()
            try? modelContext.save()
        }
    }

    private func delete(item: URLCheck) {
        withAnimation {
            modelContext.delete(item)
            try? modelContext.save()
        }
    }

    private func deleteOffsets(_ offsets: IndexSet) {
        withAnimation {
            for i in offsets { modelContext.delete(checks[i]) }
            try? modelContext.save()
        }
    }
}
