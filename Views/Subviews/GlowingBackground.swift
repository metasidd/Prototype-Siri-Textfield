import SwiftUI

struct GlowingBackground: View {
    let colors: [Color]
    let opacity: Double
    let animationDuration: Double
    @State private var rotation = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AngularGradient(
                    gradient: Gradient(colors: colors),
                    center: .center
                )
                .rotationEffect(.degrees(rotation))
                .frame(width: geometry.size.width * 2, height: geometry.size.width * 2)
                .offset(x: -geometry.size.width / 2, y: -geometry.size.width / 2)
                .blur(radius: 64)
                .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}
