import XCTest
@testable import Yearly

final class GridMetricsTests: XCTestCase {
    func testFitsEveryDayWithoutScrolling() {
        let size = CGSize(width: 375, height: 600)
        let metrics = GridMetrics.resolve(days: 365, availableSize: size)

        XCTAssertGreaterThanOrEqual(
            metrics.columns * metrics.rows,
            365,
            "the grid must have a cell for every day of the year"
        )
        XCTAssertLessThanOrEqual(CGFloat(metrics.rows) * metrics.cell, size.height)
        XCTAssertLessThanOrEqual(CGFloat(metrics.columns) * metrics.cell, size.width)
    }

    func testDotsMeetMinimumSize() {
        let metrics = GridMetrics.resolve(
            days: 366,
            availableSize: CGSize(width: 320, height: 480)
        )

        XCTAssertGreaterThanOrEqual(metrics.dotDiameter, GridMetrics.minimumDotDiameter)
    }

    func testUsesMoreColumnsOnWiderDevices() {
        let phone = GridMetrics.resolve(days: 365, availableSize: CGSize(width: 375, height: 800))
        let pad = GridMetrics.resolve(days: 365, availableSize: CGSize(width: 1024, height: 1366))

        XCTAssertGreaterThan(pad.columns, phone.columns)
    }

    func testHandlesDegenerateInput() {
        let empty = GridMetrics.resolve(days: 0, availableSize: CGSize(width: 375, height: 800))
        XCTAssertEqual(empty.columns, 0)
        XCTAssertEqual(empty.dotDiameter, 0)

        let zeroSize = GridMetrics.resolve(days: 365, availableSize: .zero)
        XCTAssertEqual(zeroSize.columns, 0)
    }

    func testGridIsCentred() {
        let size = CGSize(width: 375, height: 700)
        let metrics = GridMetrics.resolve(days: 365, availableSize: size)

        let first = metrics.center(forIndex: 0, in: size)
        let last = metrics.center(forIndex: 364, in: size)

        XCTAssertEqual(first.x, metrics.cell / 2 + (size.width - metrics.renderedSize(in: size).width) / 2, accuracy: 0.001)
        XCTAssertGreaterThan(last.x, first.x)
        XCTAssertGreaterThan(last.y, first.y)

        let rendered = metrics.renderedSize(in: size)
        XCTAssertLessThanOrEqual(rendered.width, size.width)
        XCTAssertLessThanOrEqual(rendered.height, size.height)
    }

    func testRowWrapping() {
        let size = CGSize(width: 375, height: 700)
        let metrics = GridMetrics.resolve(days: 365, availableSize: size)

        let firstOfRowTwo = metrics.center(forIndex: metrics.columns, in: size)
        let firstOfRowOne = metrics.center(forIndex: 0, in: size)

        XCTAssertEqual(firstOfRowTwo.x, firstOfRowOne.x, accuracy: 0.001)
        XCTAssertGreaterThan(firstOfRowTwo.y, firstOfRowOne.y)
    }
}