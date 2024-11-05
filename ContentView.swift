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
    @State var timer: Timer?
    @State private var maskTimer: Float = 0.0
    
    private var maskMovementSpeed: Float {
        state == .thinking ? 0.04 : 0
    }
    
    var body: some View {
        VStack {
            Spacer()
            SiriTextField(
                state: $state,
                counter: $counter
            )
            .padding(12)
            .background(textboxAnimatedOutline)
            .padding(8)
            .animation(.easeInOut(duration: 0.35), value: state)
        }
        .background(alignment: .top) {
            PhoneBackgroundView(state: $state) // Creates the phone background
                .ignoresSafeArea()
                .modifier(RippleEffect(at: origin, trigger: counter)) // Adds the ripple shader effect when textbox is focused
        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                DispatchQueue.main.async {
                    maskTimer += maskMovementSpeed // Animates the mask on a timer
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    @ViewBuilder
    private var textboxAnimatedOutline: some View {
        if state == .thinking {
            // Draw the colorful background
            GlowingBackground(colors: [.red, .blue, .green, .yellow], opacity: 0.9, animationDuration: 3)
            
            // Mask the colorful background with an animated path
                .mask {
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 32)
                            .padding(6)
                        AnimatedMask(size: geometry.size,
                                     cornerRadius: 48,
                                     t: CGFloat(maskTimer))
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                    }
                }
            // Step 4: Blur the mask so it's hidden to the user
                .blur(radius: 14)
        }
    }
}

#Preview {
    ContentView()
}
