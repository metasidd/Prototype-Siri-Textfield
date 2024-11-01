import SwiftUI

struct InteractionLayer: View {
    @Binding var state: ContentView.SiriState
    @Binding var origin: CGPoint
    @Binding var counter: Int
    
    // Gradient and masking vars
    @State var gradientSpeed: Float = 0.03
    @State var timer: Timer?
    @State private var maskTimer: Float = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                MeshGradientView(maskTimer: $maskTimer, gradientSpeed: $gradientSpeed)
                    .scaleEffect(1.3)
                    .opacity(containerOpacity)
                    .mask {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 2)
                            .frame(width: geometry.size.width * 0.8 + 32,
                                   height: 60)
                    }
                
                if state == .thinking {
                    RoundedRectangle(cornerRadius: 52, style: .continuous)
                        .stroke(Color.white, style: .init(lineWidth: 4))
                        .blur(radius: 4)
                }
            }
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
    
    private var containerOpacity: CGFloat {
        state == .thinking ? 1.0 : 0
    }
    
    private var rectangleSpeed: Float {
        state == .thinking ? 0.03 : 0
    }
} 
