import AppKit
import CoreGraphics

struct ScreenSharingDetector {
    private let knownSharingBundleIdentifiers: Set<String> = [
        "com.apple.ScreenSharing",
        "com.apple.screensharing.agent",
        "us.zoom.xos",
        "com.microsoft.teams",
        "com.microsoft.teams2",
        "com.google.Chrome",
        "com.tinyspeck.slackmacgap",
        "com.hnc.Discord",
        "com.skype.skype"
    ]

    private let knownSharingNames = [
        "screen sharing",
        "screensharing",
        "zoom",
        "microsoft teams",
        "google meet",
        "slack",
        "discord",
        "skype"
    ]

    private let sharingWindowTitleFragments = [
        "screen sharing",
        "screen share",
        "sharing screen",
        "is sharing",
        "you are sharing",
        "stop sharing",
        "presenting",
        "google meet",
        "zoom meeting",
        "microsoft teams"
    ]

    func isActive() -> Bool {
        isKnownSharingAppRunning() || isSharingWindowVisible()
    }

    private func isKnownSharingAppRunning() -> Bool {
        NSWorkspace.shared.runningApplications.contains { app in
            if let bundleIdentifier = app.bundleIdentifier,
               knownSharingBundleIdentifiers.contains(bundleIdentifier) {
                return true
            }

            let appName = app.localizedName?.lowercased() ?? ""
            return knownSharingNames.contains { appName.contains($0) }
        }
    }

    private func isSharingWindowVisible() -> Bool {
        guard CGPreflightScreenCaptureAccess() else {
            return false
        }

        guard let windows = CGWindowListCopyWindowInfo([.optionOnScreenOnly], kCGNullWindowID) as? [[String: Any]] else {
            return false
        }

        return windows.contains { window in
            let ownerName = (window[kCGWindowOwnerName as String] as? String)?.lowercased() ?? ""
            let windowName = (window[kCGWindowName as String] as? String)?.lowercased() ?? ""
            let searchableText = "\(ownerName) \(windowName)"

            return sharingWindowTitleFragments.contains { searchableText.contains($0) }
        }
    }
}
