//
//  ContentView.swift
//  Prototype-Siri-Textfield
//
//  Created by Siddhant Mehta on 2024-11-01.
//

import SwiftUI

enum SiriState {
    case none
    case thinking
}

struct ContentView: View {

    @State var state: SiriState = .none

    // Ripple animation vars
    @State var counter: Int = 0
    @State var origin: CGPoint = .init(x: 200, y: 800) // TODO: This should be dynamic depending on where the user has tapped

    // Gradient and masking vars
    @State var gradientSpeed: Float = 0.03
    @State var timer: Timer?
    @State private var maskTimer: Float = 0.0
    
    private var computedScale: CGFloat {
        switch state {
        case .none: return 1.2
        case .thinking: return 1
        }
    }
    
    private var animatedMaskBlur: CGFloat {
        switch state {
        case .none: return 8
        case .thinking: return 28
        }
    }
    
    private var rectangleSpeed: Float {
        state == .thinking ? gradientSpeed : 0
    }

    var body: some View {
        VStack {
            Spacer()
            TextInputLayer(
                state: $state,
                counter: $counter
            )
            .padding(16)
        }
        .background(alignment: .top) {
            ZStack(alignment: .top) {
                MeshAnimationView(state: $state)
                
                PhoneBackgroundView(state: $state)
                    .mask {
                        GeometryReader { geometry in
                            AnimatedRectangle(size: geometry.size,
                                              cornerRadius: 48,
                                              t: CGFloat(maskTimer))
                            .scaleEffect(computedScale)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                            .blur(radius: animatedMaskBlur)
                        }
                    }
            }
            .modifier(RippleEffect(at: origin, trigger: counter))
        }
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
    
    @ViewBuilder
    private var brightOutlineView: some View {
        if state == .thinking {
            RoundedRectangle(cornerRadius: 52, style: .continuous)
                .stroke(Color.white, style: .init(lineWidth: 4))
                .blur(radius: 4)
        }
    }
}

#Preview {
    ContentView()
}
