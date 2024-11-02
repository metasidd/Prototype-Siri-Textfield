//
//  PhoneBackground.swift
//  SiriAnimationPrototype
//
//  Created by Siddhant Mehta on 2024-06-13.
//

import SwiftUI

struct PhoneBackgroundView: View {
    @Binding var state: SiriState
    
    var body: some View {
        ZStack {
            Image("Background", bundle: .main)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.2) // avoids clipping
                .ignoresSafeArea()
            
            scrimView
        }
    }
    
    private var scrimOpacity: Double {
        switch state {
        case .none:
            0
        case .thinking:
            0.9
        }
    }
    
    private var scrimView: some View {
        Rectangle()
            .fill(
                LinearGradient(colors: [
                    Color.pink,
                    Color.blue,
                    Color.black
                ], startPoint: .bottom, endPoint: .top)
            )
            .opacity(scrimOpacity)
            .scaleEffect(1.2) // avoids clipping
    }
}

#Preview {
    PhoneBackgroundView(state: .constant(.none))
}
