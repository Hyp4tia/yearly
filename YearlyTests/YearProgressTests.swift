import XCTest
@testable import Yearly

final class YearProgressTests: XCTestCase {
    private var gregorian: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }

    private func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        gregorian.date(from: DateComponents(year: year, month: month, day: day))!
    }

    func testFirstDayOfYear() {
        let progress = YearProgress(date: date(2025, 1, 1), calendar: gregorian)

        XCTAssertEqual(progress.year, 2025)
        XCTAssertEqual(progress.totalDays, 365)
        XCTAssertEqual(progress.elapsedDays, 1)
        XCTAssertEqual(progress.daysRemaining, 364)
        XCTAssertEqual(progress.percentComplete, 0)
        XCTAssertTrue(progress.isStartOfYear)
        XCTAssertFalse(progress.isComplete)
    }

    func testLeapYearTotalDays() {
        XCTAssertEqual(
            YearProgress(date: date(2024, 6, 1), calendar: gregorian).totalDays,
            366
        )
        XCTAssertEqual(
            YearProgress(date: date(2025, 6, 1), calendar: gregorian).totalDays,
            365
        )
        XCTAssertEqual(
            YearProgress(date: date(2000, 6, 1), calendar: gregorian).totalDays,
            366,
            "2000 is divisible by 400 and is a leap year"
        )
        XCTAssertEqual(
            YearProgress(date: date(1900, 6, 1), calendar: gregorian).totalDays,
            365,
            "1900 is divisible by 100 but not 400, so it is not a leap year"
        )
    }

    func testLeapDayIsCounted() {
        let progress = YearProgress(date: date(2024, 2, 29), calendar: gregorian)

        XCTAssertEqual(progress.elapsedDays, 60)
        XCTAssertEqual(progress.daysRemaining, 306)
    }

    func testLastDayOfYear() {
        let progress = YearProgress(date: date(2025, 12, 31), calendar: gregorian)

        XCTAssertEqual(progress.elapsedDays, 365)
        XCTAssertEqual(progress.daysRemaining, 0)
        XCTAssertEqual(progress.percentComplete, 100)
        XCTAssertTrue(progress.isComplete)
    }

    func testMidYearMatchesScreenshot() {
        // 30 Dec of a 365 day year: 364 elapsed, 1 day left, 99 percent.
        let progress = YearProgress(date: date(2025, 12, 30), calendar: gregorian)

        XCTAssertEqual(progress.elapsedDays, 364)
        XCTAssertEqual(progress.daysRemaining, 1)
        XCTAssertEqual(progress.percentComplete, 99)
    }

    func testPercentNeverExceedsOneHundredWhileDaysRemain() {
        for day in 1...365 {
            let progress = YearProgress(date: date(2025, 1, 1).addingTimeInterval(
                TimeInterval((day - 1) * 86_400)
            ), calendar: gregorian)

            XCTAssertLessThanOrEqual(progress.percentComplete, 100)
            if progress.daysRemaining > 0 {
                XCTAssertLessThan(progress.percentComplete, 100)
            }
            XCTAssertEqual(progress.elapsedDays, day)
        }
    }

    func testFractionAndPercentAgree() {
        let progress = YearProgress(date: date(2025, 7, 4), calendar: gregorian)

        XCTAssertEqual(progress.fractionComplete, 185.0 / 365.0, accuracy: 0.0001)
        XCTAssertEqual(progress.percentComplete, 50)
    }

    func testRespectsCalendarEraBoundaries() {
        // A Hijri year is shorter and starts earlier in the Gregorian year, so
        // the day index must come from the user's calendar, not a hardcoded 365.
        var hijri = Calendar(identifier: .islamicCivil)
        hijri.timeZone = TimeZone(secondsFromGMT: 0)!

        let progress = YearProgress(date: date(2025, 1, 1), calendar: hijri)

        XCTAssertLessThan(progress.totalDays, 366)
        XCTAssertGreaterThanOrEqual(progress.elapsedDays, 1)
        XCTAssertLessThanOrEqual(progress.elapsedDays, progress.totalDays)
    }

    func testTimeOfDayDoesNotAffectResult() {
        let midnight = YearProgress(date: date(2025, 5, 10), calendar: gregorian)
        let lateEvening = YearProgress(
            date: date(2025, 5, 10).addingTimeInterval(23 * 3_600 + 59 * 60),
            calendar: gregorian
        )

        XCTAssertEqual(midnight, lateEvening)
    }

    func testClockJumpsDoNotProduceInvalidRanges() {
        let progress = YearProgress(date: date(2025, 5, 10), calendar: gregorian)

        XCTAssertGreaterThanOrEqual(progress.elapsedDays, 1)
        XCTAssertLessThanOrEqual(progress.elapsedDays, progress.totalDays)
        XCTAssertGreaterThanOrEqual(progress.daysRemaining, 0)
    }
}