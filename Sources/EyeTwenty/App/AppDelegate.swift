import AppKit
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate, ObservableObject {
    var timer: Timer?
    var countdownTimer: Timer?
    var overlayWindow: NSWindow?
    var simpleNotificationWindow: NSWindow?
    let screenSharingDetector = ScreenSharingDetector()
    var notificationStyle: NotificationStyle { .current }
    var canUseUserNotifications: Bool { Bundle.main.canUseUserNotifications }
    
    @Published var timeRemaining: TimeInterval = 1200
    private let totalTime: TimeInterval = 1200 // 20 minutes
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        startTimer()

        if canUseUserNotifications {
            UNUserNotificationCenter.current().delegate = self
            requestNotificationAuthorization()
        }
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                    if let error = error {
                        print("Error requesting notification authorization: \(error.localizedDescription)")
                    } else if !granted {
                        print("Notification authorization denied.")
                        // We could potentially fall back to custom notification here if desired
                    } else {
                        print("Notification authorization granted.")
                    }
                }
            } else if settings.authorizationStatus == .denied {
                print("Notification authorization was previously denied.")
                // App is not allowed to show notifications
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        countdownTimer?.invalidate()
        
        timeRemaining = totalTime
        
        timer = Timer.scheduledTimer(timeInterval: totalTime, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timeRemaining = self.totalTime
            }
        }
        RunLoop.current.add(countdownTimer!, forMode: .common)
    }
    
    func resetTimer() {
        startTimer()
    }
    
    @objc func timerFired() {
        showNotification()
    }
}
