import Foundation

enum NotificationStyle: Int {
    case fullScreen = 0
    case simple = 1

    static var current: NotificationStyle {
        NotificationStyle(rawValue: UserDefaults.standard.integer(forKey: DefaultsKeys.notificationStyle)) ?? .fullScreen
    }
}

enum DefaultsKeys {
    static let notificationStyle = "notificationStyle"
}

extension Bundle {
    var canUseUserNotifications: Bool {
        bundleURL.pathExtension == "app" &&
        object(forInfoDictionaryKey: "CFBundlePackageType") as? String == "APPL" &&
        bundleIdentifier != nil
    }
}
