import SwiftUI
#if canImport(WidgetKit)
import WidgetKit
#endif
#if canImport(UIKit)
import UIKit
#endif

/// The appearance mode options for Yearly.
enum AppearanceMode: String, CaseIterable, Identifiable {
    case system = "system"
    case light = "light"
    case dark = "dark"

    static let storageKey = "yearly_appearance_mode"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system:
            return "System"
        case .light:
            return "Light"
        case .dark:
            return "Dark (OLED)"
        }
    }

    var iconName: String {
        switch self {
        case .system:
            return "circle.lefthalf.filled"
        case .light:
            return "sun.max.fill"
        case .dark:
            return "moon.fill"
        }
    }

    #if canImport(UIKit)
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    #endif

    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

/// Helper for synchronizing appearance settings across the app and widget.
enum SharedStorage {
    static let appGroupSuite = "group.com.hyp4tia.Yearly"

    static var userDefaults: UserDefaults {
        UserDefaults(suiteName: appGroupSuite) ?? .standard
    }

    static func saveAppearance(_ mode: AppearanceMode) {
        UserDefaults.standard.set(mode.rawValue, forKey: AppearanceMode.storageKey)
        UserDefaults(suiteName: appGroupSuite)?.set(mode.rawValue, forKey: AppearanceMode.storageKey)
        #if canImport(WidgetKit)
        WidgetCenter.shared.reloadAllTimelines()
        #endif
    }

    static func currentAppearance() -> AppearanceMode {
        let raw = UserDefaults(suiteName: appGroupSuite)?.string(forKey: AppearanceMode.storageKey)
            ?? UserDefaults.standard.string(forKey: AppearanceMode.storageKey)
        return AppearanceMode(rawValue: raw ?? "") ?? .system
    }

    @MainActor
    static func applyUserInterfaceStyle(_ mode: AppearanceMode) {
        #if canImport(UIKit)
        let style = mode.userInterfaceStyle
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = style
            }
        }
        #endif
    }
}

#if canImport(UIKit)
final class WindowStyleObserverView: UIView {
    var mode: AppearanceMode = .system {
        didSet {
            apply()
        }
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        apply()
    }

    private func apply() {
        window?.overrideUserInterfaceStyle = mode.userInterfaceStyle
    }
}

struct WindowStyleModifier: UIViewRepresentable {
    let mode: AppearanceMode

    func makeUIView(context: Context) -> WindowStyleObserverView {
        let view = WindowStyleObserverView()
        view.isHidden = true
        view.mode = mode
        return view
    }

    func updateUIView(_ uiView: WindowStyleObserverView, context: Context) {
        uiView.mode = mode
    }
}
#endif
