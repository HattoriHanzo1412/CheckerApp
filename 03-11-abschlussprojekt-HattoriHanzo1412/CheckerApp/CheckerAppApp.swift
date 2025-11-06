
import SwiftUI
import SwiftData

@main
struct CheckerAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView() 
        }
        .modelContainer(for: URLCheck.self)
    }
}
