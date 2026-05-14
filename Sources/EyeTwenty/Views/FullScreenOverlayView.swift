import SwiftUI

struct FullScreenOverlayView: View {
    let window: NSWindow
    @State private var timeRemaining = 20
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Take a Break")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.white)
            
            Text("Look 20 feet away")
                .font(.system(size: 30))
                .foregroundColor(.white.opacity(0.8))
            
            Text("\(timeRemaining)")
                .font(.system(size: 100, weight: .black, design: .monospaced))
                .foregroundColor(.orange)
                .padding()
            
            Button("Skip") {
                window.close()
            }
            .buttonStyle(.borderedProminent)
            .tint(.white.opacity(0.2))
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.1)) // The window itself provides the dark background
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                window.close()
            }
        }
    }
}
