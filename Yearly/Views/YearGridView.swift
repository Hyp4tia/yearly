import SwiftUI

/// One dot per day of the year, filled for days that have passed.
struct YearGridView: View {
    let progress: YearProgress
    var isDark: Bool = false

    private var filledColor: Color {
        isDark
            ? Color(red: 0.35, green: 0.55, blue: 0.98)
            : Color(red: 0.22, green: 0.44, blue: 0.90)
    }

    private var pendingColor: Color {
        isDark
            ? Color(white: 0.22)
            : Color(white: 0.88)
    }

    var body: some View {
        Canvas { context, size in
            let metrics = GridMetrics.resolve(
                days: progress.totalDays,
                availableSize: size
            )
            guard metrics.columns > 0 else { return }

            let radius = metrics.dotDiameter / 2
            let elapsed = progress.elapsedDays

            for index in 0..<progress.totalDays {
                let center = metrics.center(forIndex: index, in: size)
                let dot = Path(
                    ellipseIn: CGRect(
                        x: center.x - radius,
                        y: center.y - radius,
                        width: metrics.dotDiameter,
                        height: metrics.dotDiameter
                    )
                )
                context.fill(
                    dot,
                    with: .color(index < elapsed ? filledColor : pendingColor)
                )
            }
        }
        .accessibilityElement()
        .accessibilityLabel(
            Text(verbatim: String(
                localized: "accessibility.grid.label",
                defaultValue: "Year progress"
            ))
        )
        .accessibilityValue(Text(verbatim: progress.accessibilityDescription))
        .accessibilityAddTraits(.isImage)
    }
}

#Preview("Dark") {
    YearGridView(progress: YearProgress(), isDark: true)
        .padding()
        .background(Color.black)
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    YearGridView(progress: YearProgress(), isDark: false)
        .padding()
        .background(Color.white)
        .preferredColorScheme(.light)
}