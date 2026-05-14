import AppKit
import SwiftUI
import UserNotifications

extension AppDelegate {
    @objc func showNotification() {
        guard !screenSharingDetector.isActive() else {
            return
        }

        switch notificationStyle {
        case .fullScreen:
            showFullScreenOverlay()
        case .simple:
            showSimpleNotification()
        }
    }

    func showFullScreenOverlay() {
        overlayWindow?.close()

        let window = NSWindow(
            contentRect: NSScreen.main?.frame ?? NSRect(x: 0, y: 0, width: 800, height: 600),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        window.isOpaque = false
        window.backgroundColor = NSColor.black.withAlphaComponent(0.8)
        window.level = .floating
        window.ignoresMouseEvents = false
        window.isReleasedWhenClosed = false
        window.contentView = NSHostingView(rootView: FullScreenOverlayView(window: window))
        window.makeKeyAndOrderFront(nil)
        overlayWindow = window
    }

    func showSimpleNotification() {
        guard canUseUserNotifications else {
            showSimpleNotificationWindow()
            return
        }

        let content = UNMutableNotificationContent()
        content.title = "Time for a break!"
        content.body = "Look at something 20 feet away for 20 seconds."
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }

    func showSimpleNotificationWindow() {
        simpleNotificationWindow?.close()

        let size = NSSize(width: 360, height: 116)
        let visibleFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 800, height: 600)
        let origin = NSPoint(
            x: visibleFrame.maxX - size.width - 20,
            y: visibleFrame.maxY - size.height - 20
        )
        let window = NSWindow(
            contentRect: NSRect(origin: origin, size: size),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .floating
        window.ignoresMouseEvents = false
        window.isReleasedWhenClosed = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.contentView = NSHostingView(rootView: SimpleNotificationView(window: window))
        window.orderFrontRegardless()
        simpleNotificationWindow = window
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
