import SwiftUI

@main
struct YearlyApp: App {
    @AppStorage(AppearanceMode.storageKey) private var appearance: AppearanceMode = .system

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .preferredColorScheme(appearance.colorScheme)
        }
    }
}