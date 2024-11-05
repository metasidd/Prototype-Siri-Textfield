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

    private var scrimOpacity: Double {
        switch state {
        case .none: 0
        case .thinking: 0.70
        }
    }

    var body: some View {
        VStack {
            Spacer()
            SiriTextField(
                state: $state,
                counter: $counter
            )
            .padding(8)
            .glowingTextField(state: state)
            .padding(8)
            .animation(.easeInOut(duration: 0.35), value: state)
        }
        .background {
            ZStack {
                PhoneWallpaperView()
                ScrimView(opacity: scrimOpacity)
                    .animation(.easeInOut(duration: 0.35), value: state)
            }
            .modifier(RippleEffect(at: origin, trigger: counter))
        }
    }
}

#Preview {
    ContentView()
}
