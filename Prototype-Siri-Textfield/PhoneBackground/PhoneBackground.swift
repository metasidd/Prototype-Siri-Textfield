//
//  PhoneBackground.swift
//  SiriAnimationPrototype
//
//  Created by Siddhant Mehta on 2024-06-13.
//

import SwiftUI

struct PhoneBackground: View {
    @Binding var state: ContentView.SiriState
    @Binding var origin: CGPoint
    @Binding var counter: Int
    @State var text: String = "Hello"
    @FocusState private var isFocused: Bool

    private var scrimOpacity: Double {
        switch state {
        case .none:
            0
        case .thinking:
            0.8
        }
    }

    private var iconName: String {
        switch state {
        case .none:
            "mic"
        case .thinking:
            "pause"
        }
    }

    var body: some View {
        ZStack {
            Image("Background", bundle: .main)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.2) // avoids clipping
                .ignoresSafeArea()

            Rectangle()
                .fill(Color.black)
                .opacity(scrimOpacity)
                .scaleEffect(1.2) // avoids clipping

            VStack {
                welcomeText

                textfield
                    .focused($isFocused)
                    .onChange(of: isFocused) { _, newValue in
                        withAnimation(.easeInOut(duration: 0.9)) {
                            state = newValue ? .thinking : .none
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .onPressingChanged { point in
                if let point {
                    origin = point
                    counter += 1
                }
            }
            .padding(.bottom, 64)
        }
    }

    private var textfield: some View {
        TextField("Test", text: $text)
            .placeholder(when: text.isEmpty) {
                Text("Placeholder recreated").foregroundColor(.gray)
        }
        .textFieldStyle(.plain)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .font(.system(size: 24))
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 32.0, style: .continuous)
                .fill(Color.gray.opacity(0.1))
        )
        .padding(16)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
    }

    @ViewBuilder
    private var welcomeText: some View {
        if state == .thinking {
            Text("What are you looking for?")
                .foregroundStyle(Color.white)
                .frame(maxWidth: 240, maxHeight: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .animation(.easeInOut(duration: 0.2), value: state)
                .contentTransition(.opacity)
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    PhoneBackground(
        state: .constant(.none),
        origin: .constant(CGPoint(x: 0.5, y: 0.5)),
        counter: .constant(0)
    )
}
