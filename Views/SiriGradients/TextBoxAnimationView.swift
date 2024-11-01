//
//  TextBoxAnimationView.swift
//  Prototype-Siri-Textfield
//
//  Created by Siddhant Mehta on 2024-11-01.
//

import SwiftUI

struct TextBoxAnimationView: View {
    @Binding var state: SiriState
    
    // Gradient and masking vars
    @State var gradientSpeed: Float = 0.03
    @State var timer: Timer?
    @State private var maskTimer: Float = 0.0
    
    private var containerOpacity: CGFloat {
        state == .thinking ? 1.0 : 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                MeshGradientView(maskTimer: $maskTimer, gradientSpeed: $gradientSpeed)
                    .scaleEffect(1.3)
                    .opacity(containerOpacity)
            }
            .ignoresSafeArea()
        }
    }
}
