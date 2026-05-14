import SwiftUI

struct SimpleNotificationView: View {
    let window: NSWindow
    let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "eye")
                .font(.system(size: 26, weight: .semibold))
                .foregroundColor(.orange)
                .frame(width: 34, height: 34)

            VStack(alignment: .leading, spacing: 4) {
                Text("Time for a break!")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("Look at something 20 feet away for 20 seconds.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 8)

            Button {
                window.close()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .semibold))
            }
            .buttonStyle(.plain)
            .foregroundColor(.secondary)
        }
        .padding(16)
        .frame(width: 360, height: 116)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.primary.opacity(0.12), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.18), radius: 18, x: 0, y: 10)
        .onReceive(timer) { _ in
            window.close()
        }
    }
}
