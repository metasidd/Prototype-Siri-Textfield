//
//  TextboxMeshGradientView.swift
//  Prototype-Siri-Textfield
//
//  Created by Siddhant Mehta on 2024-11-01.
//

import SwiftUI

struct TextboxMeshGradientView: View {
    @Binding var maskTimer: Float
    @Binding var gradientSpeed: Float

    var body: some View {
        MeshGradient(width: 3, height: 3, points: [
            .init(0, 0), .init(0.0, 0), .init(1, 0),

            [sinInRange(-0.0 ... -0.0, offset: 0, timeScale: 0.342, t: maskTimer), sinInRange(0.1 ... 0.2, offset: 0.42, timeScale: 0.984, t: maskTimer)],
            [sinInRange(0.01 ... 0.2, offset: 0.02, timeScale: 0.084, t: maskTimer), sinInRange(0.05 ... 0.2, offset: 1.2, timeScale: 0.242, t: maskTimer)],
            [sinInRange(0.2 ... 0.3, offset: 0.239, timeScale: 0.084, t: maskTimer), sinInRange(0.2 ... 0.15, offset: 0.07, timeScale: 0.642, t: maskTimer)],
            [sinInRange(-0.2 ... 0.0, offset: 0.3, timeScale: 0.442, t: maskTimer), sinInRange(0.3 ... 0.4, offset: 0.75, timeScale: 0.984, t: maskTimer)],
            [sinInRange(0.1 ... 0.2, offset: 0.1, timeScale: 0.784, t: maskTimer), sinInRange(0.25 ... 0.3, offset: 0.05, timeScale: 0.772, t: maskTimer)],
            [sinInRange(0.25 ... 0.4, offset: 0.25, timeScale: 0.056, t: maskTimer), sinInRange(0.4 ... 0.5, offset: 0.17, timeScale: 0.342, t: maskTimer)],
        ], colors: [
            .yellow, .purple, .indigo,
            .orange, .red, .blue,
            .indigo, .green, .mint,
        ])
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                DispatchQueue.main.async {
                    maskTimer += gradientSpeed
                }
            }
        }
        .ignoresSafeArea()
    }

    private func sinInRange(_ range: ClosedRange<Float>, offset: Float, timeScale: Float, t: Float) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2
        return midPoint + amplitude * sin(timeScale * t + offset)
    }
}

#Preview {
    TextboxMeshGradientView(maskTimer: .constant(0.0), gradientSpeed: .constant(0.05))
}
