
import SwiftUI
import SwiftData


struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Examination", systemImage: "shield.lefthalf.filled")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}
