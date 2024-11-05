import SwiftUI

struct GlowingTextFieldModifier: ViewModifier {
    let state: SiriState
    @State private var maskTimer: Float = 0.0
    @State private var timer: Timer?
    
    private var maskMovementSpeed: Float {
        state == .thinking ? 0.02 : 0
    }
    
    func body(content: Content) -> some View {
        content
            .background(animatedGlowingOutline)
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
                }
            }
            .blur(radius: 12) // Switch off this layer to see how the mask is moving.
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.008, repeats: true) { _ in
                    withAnimation {
                        maskTimer += maskMovementSpeed
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }
}

// Convenience extension
extension View {
    func glowingTextField(state: SiriState) -> some View {
        modifier(GlowingTextFieldModifier(state: state))
    }
} 
