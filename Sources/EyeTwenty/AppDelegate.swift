import AppKit
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    var timer: Timer?
    var overlayWindow: NSWindow?
    var simpleNotificationWindow: NSWindow?
    let screenSharingDetector = ScreenSharingDetector()
    var notificationStyle: NotificationStyle { .current }
    var canUseUserNotifications: Bool { Bundle.main.canUseUserNotifications }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        startTimer()

        if canUseUserNotifications {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
        }
    }
    
    func startTimer() {
        // 20 minutes = 1200 seconds
        timer = Timer.scheduledTimer(timeInterval: 1200, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    @objc func timerFired() {
        showNotification()
    }
}
