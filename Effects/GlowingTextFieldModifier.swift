import SwiftUI

struct GlowingTextFieldModifier: ViewModifier {
    let state: SiriState
    @State private var maskTimer: Float = 0.0
    @State private var timer: Timer?
    
    private var maskMovementSpeed: Float {
        state == .thinking ? 0.04 : 0
    }
    
    func body(content: Content) -> some View {
        content
            .background(animatedGlowingOutline)
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    DispatchQueue.main.async {
                        maskTimer += maskMovementSpeed
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
    }
    
    @ViewBuilder
    private var animatedGlowingOutline: some View {
        if state == .thinking {
            GlowingBackground(
                colors: [.red, .blue, .green, .yellow],
                opacity: 0.9,
                animationDuration: 3
            )
            .mask {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 32)
                        .padding(6)
                    AnimatedMask(
                        size: geometry.size,
                        cornerRadius: 48,
                        t: CGFloat(maskTimer)
                    )
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                }
            }
            .blur(radius: 14)
        }
    }
}

// Convenience extension
extension View {
    func glowingTextField(state: SiriState) -> some View {
        modifier(GlowingTextFieldModifier(state: state))
    }
} 