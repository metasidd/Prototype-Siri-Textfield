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
        ZStack {
            BackgroundView()
            
            InteractionLayer(state: $state, 
                           origin: $origin, 
                           counter: $counter)
            
            PhoneBackground(state: $state, 
                          origin: $origin, 
                          counter: $counter)
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
    }

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
}

#Preview {
    ContentView()
}
