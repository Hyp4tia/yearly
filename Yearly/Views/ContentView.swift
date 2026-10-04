import SwiftUI
#if canImport(WidgetKit)
import WidgetKit
#endif

struct ContentView: View {
    @AppStorage(AppearanceMode.storageKey) private var appearance: AppearanceMode = .system
    @Environment(\.colorScheme) private var colorScheme
    @State private var showingAbout = false
    @State private var now = Date()

    private var progress: YearProgress {
        YearProgress(date: now)
    }

    private var isDarkMode: Bool {
        switch appearance {
        case .system:
            return colorScheme == .dark
        case .light:
            return false
        case .dark:
            return true
        }
    }

    private var appBackgroundColor: Color {
        isDarkMode ? Color.black : Color.white
    }

    var body: some View {
        ZStack {
            appBackgroundColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                YearGridView(progress: progress, isDark: isDarkMode)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 28)
                    .padding(.top, 40)
                    .padding(.bottom, 32)

                YearSummaryView(progress: progress, isDark: isDarkMode)
                    .padding(.bottom, 28)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        #if canImport(UIKit)
        .background(WindowStyleModifier(mode: appearance))
        #endif
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(appBackgroundColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showingAbout = true
                } label: {
                    Image(systemName: "info.circle")
                        .font(.body)
                        .foregroundStyle(isDarkMode ? .white : .black)
                        .accessibilityLabel(Text("About Yearly"))
                }
            }

            ToolbarItem(placement: .principal) {
                Text(verbatim: String(progress.year))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(isDarkMode ? .white : .black)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Picker("Appearance", selection: $appearance) {
                        ForEach(AppearanceMode.allCases) { mode in
                            Label(mode.title, systemImage: mode.iconName)
                                .tag(mode)
                        }
                    }
                    .pickerStyle(.inline)
                } label: {
                    Image(systemName: appearance.iconName)
                        .font(.body)
                        .foregroundStyle(isDarkMode ? .white : .black)
                        .accessibilityLabel(Text("Appearance: \(appearance.title)"))
                }
            }
        }
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
        .onChange(of: appearance) { _, newMode in
            SharedStorage.saveAppearance(newMode)
            SharedStorage.applyUserInterfaceStyle(newMode)
        }
        .task {
            SharedStorage.saveAppearance(appearance)
            SharedStorage.applyUserInterfaceStyle(appearance)
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

#Preview("Dark") {
    NavigationStack {
        ContentView()
    }
}

#Preview("Light") {
    NavigationStack {
        ContentView()
    }
}