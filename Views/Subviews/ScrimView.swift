import SwiftUI

struct ScrimView: View {
    let opacity: Double
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(colors: [
                    Color.black,
                    Color.blue.opacity(0.75),
                    Color.pink.opacity(0.5)
                ], startPoint: .center, endPoint: .top)
            )
            .opacity(opacity)
            .scaleEffect(1.2) // avoids clipping
            .ignoresSafeArea()
    }
}

#Preview {
    ScrimView(opacity: 0.7)
} 