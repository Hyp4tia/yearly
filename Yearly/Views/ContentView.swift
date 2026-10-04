import SwiftUI
#if canImport(WidgetKit)
import WidgetKit
#endif

struct ContentView: View {
    @AppStorage(AppearanceMode.storageKey) private var appearance: AppearanceMode = .system
    @State private var showingAbout = false
    @State private var now = Date()

    private var progress: YearProgress {
        YearProgress(date: now)
    }

    var body: some View {
        VStack(spacing: 0) {
            YearGridView(progress: progress)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 28)
                .padding(.top, 40)
                .padding(.bottom, 32)

            YearSummaryView(progress: progress)
                .padding(.bottom, 28)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .navigationTitle(Text(verbatim: String(progress.year)))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showingAbout = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.primary)
                        .accessibilityLabel(Text("About Yearly"))
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Picker("Appearance", selection: $appearance) {
                        ForEach(AppearanceMode.allCases) { mode in
                            Label(mode.title, systemImage: mode.iconName)
                                .tag(mode)
                        }
                    }
                } label: {
                    Image(systemName: appearance.iconName)
                        .foregroundStyle(.primary)
                        .accessibilityLabel(Text("Appearance: \(appearance.title)"))
                }
            }
        }
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
        .onChange(of: appearance) { _, newMode in
            SharedStorage.saveAppearance(newMode)
        }
        .task {
            SharedStorage.saveAppearance(appearance)
            await refreshAtMidnight()
        }
    }

    /// Keeps the grid correct if the app stays open across midnight or the
    /// device wakes from sleep.
    private func refreshAtMidnight() async {
        while !Task.isCancelled {
            let calendar = Calendar.autoupdatingCurrent
            let startOfToday = calendar.startOfDay(for: now)
            let nextMidnight = calendar.date(
                byAdding: .day,
                value: 1,
                to: startOfToday
            ) ?? now.addingTimeInterval(60)

            let delay = max(nextMidnight.timeIntervalSince(now) + 1, 1)
            do {
                try await Task.sleep(for: .seconds(delay))
            } catch {
                return
            }
            now = Date()
            #if canImport(WidgetKit)
            WidgetCenter.shared.reloadAllTimelines()
            #endif
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
    .preferredColorScheme(.dark)
}

#Preview("Light") {
    NavigationStack {
        ContentView()
    }
    .preferredColorScheme(.light)
}