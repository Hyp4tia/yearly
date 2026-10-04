import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> YearProgressEntry {
        YearProgressEntry(date: Date(), progress: YearProgress(), appearance: .system)
    }

    func getSnapshot(in context: Context, completion: @escaping (YearProgressEntry) -> Void) {
        let entry = YearProgressEntry(
            date: Date(),
            progress: YearProgress(),
            appearance: SharedStorage.currentAppearance()
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<YearProgressEntry>) -> Void) {
        let currentDate = Date()
        let progress = YearProgress(date: currentDate)
        let appearance = SharedStorage.currentAppearance()
        let entry = YearProgressEntry(date: currentDate, progress: progress, appearance: appearance)

        // Schedule next update for exactly 12:00:00 AM (midnight) the next day
        let calendar = Calendar.autoupdatingCurrent
        let startOfToday = calendar.startOfDay(for: currentDate)
        let nextMidnight = calendar.date(byAdding: .day, value: 1, to: startOfToday)
            ?? currentDate.addingTimeInterval(86400)

        let timeline = Timeline(entries: [entry], policy: .after(nextMidnight))
        completion(timeline)
    }
}

struct YearProgressEntry: TimelineEntry {
    let date: Date
    let progress: YearProgress
    let appearance: AppearanceMode
}

struct YearlyWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    @Environment(\.colorScheme) var systemColorScheme

    private var resolvedColorScheme: ColorScheme {
        switch entry.appearance {
        case .system:
            return systemColorScheme
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }

    private var isDark: Bool {
        resolvedColorScheme == .dark
    }

    private var accentColor: Color {
        Color(red: 0.35, green: 0.55, blue: 0.98)
    }

    var body: some View {
        Group {
            switch family {
            case .systemSmall:
                smallView
            case .systemMedium:
                mediumView
            case .accessoryRectangular:
                accessoryRectangularView
            case .accessoryInline:
                accessoryInlineView
            default:
                smallView
            }
        }
        .environment(\.colorScheme, resolvedColorScheme)
        .containerBackground(for: .widget) {
            isDark ? Color.black : Color.white
        }
    }

    // MARK: - Small Widget
    private var smallView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(verbatim: String(entry.progress.year))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "calendar")
                    .font(.caption)
                    .foregroundStyle(accentColor)
            }

            Spacer()

            VStack(alignment: .leading, spacing: 2) {
                Text(verbatim: "\(entry.progress.daysRemaining)")
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)

                Text(verbatim: entry.progress.daysRemaining == 1 ? "day left" : "days left")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .leading, spacing: 5) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 5)

                        Capsule()
                            .fill(accentColor)
                            .frame(
                                width: max(geo.size.width * CGFloat(entry.progress.fractionComplete), 5),
                                height: 5
                            )
                    }
                }
                .frame(height: 5)

                Text(verbatim: "\(entry.progress.percentComplete)% completed")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - Medium Widget
    private var mediumView: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                Text(verbatim: String(entry.progress.year))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)

                Spacer()

                Text(verbatim: "\(entry.progress.daysRemaining)")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)

                Text(verbatim: entry.progress.daysRemaining == 1 ? "day left in the year" : "days left in the year")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)

                Spacer()
            }

            Divider()
                .opacity(0.3)

            VStack(alignment: .leading, spacing: 10) {
                Spacer()

                VStack(alignment: .leading, spacing: 2) {
                    Text(verbatim: "\(entry.progress.percentComplete)%")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(accentColor)

                    Text(verbatim: "of the year complete")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }

                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.secondary.opacity(0.2))
                            .frame(height: 6)

                        Capsule()
                            .fill(accentColor)
                            .frame(
                                width: max(geo.size.width * CGFloat(entry.progress.fractionComplete), 6),
                                height: 6
                            )
                    }
                }
                .frame(height: 6)

                Text(verbatim: "\(entry.progress.elapsedDays) of \(entry.progress.totalDays) days passed")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Spacer()
            }
        }
    }

    // MARK: - Lock Screen Widgets
    private var accessoryRectangularView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(verbatim: "\(entry.progress.daysRemaining) days left")
                .font(.headline)
            Text(verbatim: "\(entry.progress.percentComplete)% of \(entry.progress.year) complete")
                .font(.caption)
        }
    }

    private var accessoryInlineView: some View {
        Text(verbatim: "\(entry.progress.daysRemaining)d left (\(entry.progress.percentComplete)%)")
    }
}

struct YearlyWidget: Widget {
    let kind: String = "YearlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            YearlyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Yearly Progress")
        .description("Shows days left in the year and percentage of the year completed.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryRectangular,
            .accessoryInline
        ])
    }
}

#Preview("Small Dark", as: .systemSmall) {
    YearlyWidget()
} timeline: {
    YearProgressEntry(date: .now, progress: YearProgress(), appearance: .dark)
}

#Preview("Small Light", as: .systemSmall) {
    YearlyWidget()
} timeline: {
    YearProgressEntry(date: .now, progress: YearProgress(), appearance: .light)
}

#Preview("Medium Dark", as: .systemMedium) {
    YearlyWidget()
} timeline: {
    YearProgressEntry(date: .now, progress: YearProgress(), appearance: .dark)
}
