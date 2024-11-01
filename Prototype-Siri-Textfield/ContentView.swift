//
//  ContentView.swift
//  Prototype-Siri-Textfield
//
//  Created by Siddhant Mehta on 2024-11-01.
//

import SwiftUI

struct ContentView: View {
    enum SiriState {
        case none
        case thinking
    }

    @State var state: SiriState = .none

    // Ripple animation vars
    @State var counter: Int = 0
    @State var origin: CGPoint = .init(x: 0.5, y: 0.5)

    // Gradient and masking vars
    @State var gradientSpeed: Float = 0.03
    @State var timer: Timer?
    @State private var maskTimer: Float = 0.0

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // Modify gradient to be a border mask
                    MeshGradientView(maskTimer: $maskTimer, gradientSpeed: $gradientSpeed)
                        .scaleEffect(1.3)
                        .opacity(containerOpacity)
                        .mask {
                            // Create a border mask around the TextField
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 2)
                                .frame(width: geometry.size.width * 0.8 + 32,
                                       height: 60)
                        }
                    
                    // Brightness rim on edges
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
            
            
            // Phone background mock, includes button
            PhoneBackground(state: $state, origin: $origin, counter: $counter)
                .mask {
                    GeometryReader { geometry in
                        AnimatedRectangle(size: geometry.size, cornerRadius: 48, t: CGFloat(maskTimer))
                            .scaleEffect(computedScale)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .blur(radius: animatedMaskBlur)
                    }
                }
        }
    }

    private var computedScale: CGFloat {
        switch state {
        case .none: return 1.2
        case .thinking: return 1
        }
    }

    private var rectangleSpeed: Float {
        switch state {
        case .none: return 0
        case .thinking: return 0.03
        }
    }

    private var animatedMaskBlur: CGFloat {
        switch state {
        case .none: return 8
        case .thinking: return 28
        }
    }

    private var containerOpacity: CGFloat {
        switch state {
        case .none: return 0
        case .thinking: return 1.0
        }
    }
}

#Preview {
    ContentView()
}
