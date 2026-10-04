import CoreGraphics

/// Resolved geometry for the year dot grid.
///
/// The grid is always a single block of square cells so the lattice stays
/// even, and it is sized to fit whatever space it is given. That keeps one
/// dot per day visible on every device and in every orientation without
/// scrolling.
struct GridMetrics: Equatable {
    /// Number of dots per row.
    let columns: Int
    /// Number of rows needed to hold every day.
    let rows: Int
    /// Side length of one square cell, in points.
    let cell: CGFloat
    /// Diameter of one dot, in points.
    let dotDiameter: CGFloat

    static let minimumDotDiameter: CGFloat = 4
    static let dotToCellRatio: CGFloat = 0.58

    /// Smallest dot width we are willing to draw. Below this the grid would
    /// turn into an unreadable smudge.
    static let preferredMinimumPitch: CGFloat = 24

    static func resolve(days: Int, availableSize: CGSize) -> GridMetrics {
        guard days > 0,
              availableSize.width > 0,
              availableSize.height > 0
        else {
            return GridMetrics(columns: 0, rows: 0, cell: 0, dotDiameter: 0)
        }

        let maxColumns = max(
            1,
            Int((availableSize.width / preferredMinimumPitch).rounded(.down))
        )
        let columns = min(days, maxColumns)
        let rows = Int((Double(days) / Double(columns)).rounded(.up))

        let cell = min(
            availableSize.width / CGFloat(columns),
            availableSize.height / CGFloat(rows)
        )
        let dotDiameter = max(minimumDotDiameter, cell * dotToCellRatio)

        return GridMetrics(
            columns: columns,
            rows: rows,
            cell: cell,
            dotDiameter: dotDiameter
        )
    }

    /// Total size of the drawn lattice, centred inside `availableSize`.
    func renderedSize(in availableSize: CGSize) -> CGSize {
        CGSize(width: cell * CGFloat(columns), height: cell * CGFloat(rows))
    }

    /// Centre point for the dot representing `index` (zero based, read left to
    /// right then top to bottom).
    func center(forIndex index: Int, in availableSize: CGSize) -> CGPoint {
        let rendered = renderedSize(in: availableSize)
        let originX = (availableSize.width - rendered.width) / 2
        let originY = (availableSize.height - rendered.height) / 2

        let column = index % max(columns, 1)
        let row = index / max(columns, 1)

        return CGPoint(
            x: originX + (CGFloat(column) + 0.5) * cell,
            y: originY + (CGFloat(row) + 0.5) * cell
        )
    }
}