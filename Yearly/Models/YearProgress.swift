import Foundation

/// An immutable snapshot of how far the current year has progressed.
///
/// The value is derived from a `Date` and a `Calendar`, which means it honours
/// leap years, the user's region, and any non-Gregorian calendar the user has
/// selected in Settings.
struct YearProgress: Equatable, Sendable {
    /// The moment in time this snapshot was taken.
    let date: Date
    /// The calendar used for every computation.
    let calendar: Calendar
    /// The year `date` falls in, expressed in `calendar`'s terms.
    let year: Int
    /// Number of days in `year` (365, or 366 in a leap year).
    let totalDays: Int
    /// Days of `year` that have started, including `date` itself.
    let elapsedDays: Int

    init(date: Date = .now, calendar: Calendar = .autoupdatingCurrent) {
        self.date = date
        self.calendar = calendar

        let yearComponents = calendar.dateComponents([.year], from: date)
        self.year = yearComponents.year ?? calendar.component(.year, from: date)

        let total = calendar.range(of: .day, in: .year, for: date)?.count ?? 365
        self.totalDays = total

        let startOfYear = calendar.date(from: yearComponents) ?? date
        let startOfToday = calendar.startOfDay(for: date)
        let wholeDays = calendar.dateComponents(
            [.day],
            from: startOfYear,
            to: startOfToday
        ).day ?? 0

        // Clamp so the value stays sane if the device clock jumps around.
        self.elapsedDays = min(max(wholeDays + 1, 1), total)
    }

    /// Days of the year that have not started yet.
    var daysRemaining: Int { totalDays - elapsedDays }

    /// Completion in the range `0...1`.
    var fractionComplete: Double {
        guard totalDays > 0 else { return 0 }
        return Double(elapsedDays) / Double(totalDays)
    }

    /// Completion as a whole percentage, truncated so it never reads 100%
    /// while days remain.
    var percentComplete: Int {
        Int((fractionComplete * 100).rounded(.down))
    }

    /// `true` on the final day of the year.
    var isComplete: Bool { elapsedDays >= totalDays }

    /// Whether `date` is the first day of the year.
    var isStartOfYear: Bool { elapsedDays == 1 }

    /// Spoken description used by VoiceOver.
    var accessibilityDescription: String {
        String(
            format: String(localized: "accessibility.progress", defaultValue: "Day %1$lld of %2$lld. %3$lld percent complete."),
            elapsedDays,
            totalDays,
            percentComplete
        )
    }

    static func == (lhs: YearProgress, rhs: YearProgress) -> Bool {
        lhs.year == rhs.year &&
        lhs.totalDays == rhs.totalDays &&
        lhs.elapsedDays == rhs.elapsedDays &&
        lhs.calendar == rhs.calendar
    }
}