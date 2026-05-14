import SwiftUI

@main
struct EyeTwentyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage(DefaultsKeys.notificationStyle) private var notificationStyle = NotificationStyle.fullScreen.rawValue
    
    var body: some Scene {
        MenuBarExtra("Eye Twenty", systemImage: "eye") {
            Button("Show Notification Now") {
                appDelegate.showNotification()
            }
            .keyboardShortcut("n")

            Divider()

            Picker("Notification Style", selection: $notificationStyle) {
                Text("Full Screen").tag(NotificationStyle.fullScreen.rawValue)
                Text("Simple").tag(NotificationStyle.simple.rawValue)
            }
            .pickerStyle(.inline)

            Divider()

            Button("Quit") {
                NSApp.terminate(nil)
            }
            .keyboardShortcut("q")
        }
        .menuBarExtraStyle(.menu)
    }
}
