import SwiftUI

@main
struct EyeTwentyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        MenuBarExtra("Eye Twenty", systemImage: "eye") {
            MenuContentView(appDelegate: appDelegate)
        }
        .menuBarExtraStyle(.menu)
    }
}

struct MenuContentView: View {
    @ObservedObject var appDelegate: AppDelegate
    @AppStorage(DefaultsKeys.notificationStyle) private var notificationStyle = NotificationStyle.fullScreen.rawValue
    
    var body: some View {
        Text(timeString(from: appDelegate.timeRemaining))
        
        Button("Reset Timer") {
            appDelegate.resetTimer()
        }
        
        Button("Show Notification Now") {
            appDelegate.showNotification()
        }

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
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "Time until next break: %02d:%02d", minutes, seconds)
    }
}
