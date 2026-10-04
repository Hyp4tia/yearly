import SwiftUI

/// "2d left · 99%" style summary shown under the grid.
struct YearSummaryView: View {
    let progress: YearProgress
    var isDark: Bool = false

    private var remainingColor: Color {
        isDark ? Color(red: 0.35, green: 0.55, blue: 0.98) : Color(red: 0.22, green: 0.44, blue: 0.90)
    }

    var body: some View {
        HStack(spacing: 6) {
            Text(daysRemainingText)
                .foregroundStyle(remainingColor)
            Text(verbatim: "·")
                .foregroundStyle(.secondary)
            Text(percentText)
                .foregroundStyle(.secondary)
                .monospacedDigit()
        }
        .font(.footnote)
        .lineLimit(1)
        .minimumScaleFactor(0.6)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(verbatim: accessibilityText))
    }

    private var daysRemainingText: String {
        let value = progress.daysRemaining.formatted()
        return String(
            format: String(localized: "summary.daysLeft", defaultValue: "%@d left"),
            value
        )
    }

    private var percentText: String {
        let value = progress.percentComplete.formatted()
        return String(
            format: String(localized: "summary.percent", defaultValue: "%@%%"),
            value
        )
    }

    private var accessibilityText: String {
        let days = progress.daysRemaining.formatted()
        let percent = progress.percentComplete.formatted()
        return String(
            format: String(localized: "accessibility.summary", defaultValue: "%1$@ days left, %2$@ percent of the year complete."),
            days,
            percent
        )
    }
}

#Preview {
    VStack(spacing: 24) {
        YearSummaryView(progress: YearProgress())
        YearSummaryView(
            progress: YearProgress(
                date: Calendar.current.date(
                    from: DateComponents(year: 2025, month: 12, day: 30)
                )!
            )
        )
    }
}