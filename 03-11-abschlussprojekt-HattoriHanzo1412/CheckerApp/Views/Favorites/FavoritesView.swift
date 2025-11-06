


import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(
        filter: #Predicate<URLCheck> { $0.isFavorite == true },
        sort: \URLCheck.time,
        order: .reverse
    )
    private var favorites: [URLCheck]

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            Group {
                if favorites.isEmpty {
                    EmptyFavoritesView()
                } else {
                    List {
                        ForEach(favorites) { item in
                            FavoriteRow(
                                check: item,
                                toggle: { toggleFavorite(item) },
                                delete: { delete(item: item) }
                            )
                           
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    toggleFavorite(item)
                                } label: {
                                    Label(
                                        item.isFavorite ? "Put away" : "Add to favorites",
                                        systemImage: item.isFavorite ? "star.slash" : "star"
                                    )
                                }
                                .tint(.yellow)
                            }
                            
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    delete(item: item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .onDelete(perform: deleteOffsets)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                if !favorites.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Clear") {
                            withAnimation {
                                favorites.forEach { modelContext.delete($0) }
                                try? modelContext.save()
                            }
                        }
                    }
                }
            }
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
            for i in offsets { modelContext.delete(favorites[i]) }
            try? modelContext.save()
        }
    }
}
