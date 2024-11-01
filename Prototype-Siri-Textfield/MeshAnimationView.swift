import SwiftUI

struct MeshAnimationView: View {
    @Binding var state: SiriState
    @Binding var origin: CGPoint
    @Binding var counter: Int
    
    // Gradient and masking vars
    @State var gradientSpeed: Float = 0.03
    @State var timer: Timer?
    @State private var maskTimer: Float = 0.0
    
    private var containerOpacity: CGFloat {
        state == .thinking ? 1.0 : 0
    }
    
    private var rectangleSpeed: Float {
        state == .thinking ? gradientSpeed : 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                MeshGradientView(maskTimer: $maskTimer, gradientSpeed: $gradientSpeed)
                    .scaleEffect(1.3)
                    .opacity(containerOpacity)
            }
            .ignoresSafeArea()
            .modifier(RippleEffect(at: origin, trigger: counter))
            .onAppear {
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    DispatchQueue.main.async {
                        maskTimer += rectangleSpeed
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }
}
