import SwiftUI

struct TextInputLayer: View {
    @Binding var state: SiriState
    @Binding var counter: Int
    
    @State var text: String = ""
    @FocusState private var isFocused: Bool
    
    private var outlineGradient: LinearGradient {
        if isFocused {
            return LinearGradient(colors: [
                Color.white.opacity(1),
                Color.white.opacity(0.5)
            ], startPoint: .top, endPoint: .bottom)
        } else {
            return LinearGradient(colors: [
                Color.white.opacity(0.25),
                Color.white.opacity(0.5)
            ], startPoint: .top, endPoint: .bottom)
        }
    }
    
    private var backgroundGradient: LinearGradient {
        if isFocused {
            return LinearGradient(colors: [
                Color.white.opacity(0.9),
                Color.white.opacity(0.7)
            ], startPoint: .bottom, endPoint: .top)
        } else {
            return LinearGradient(colors: [
                Color.white.opacity(0.25),
                Color.white.opacity(0.1)
            ], startPoint: .bottom, endPoint: .top)
        }
    }
    
    private var iconColorGradient: LinearGradient {
        if isFocused {
            return LinearGradient(colors: [
                Color.blue,
                Color.pink
            ], startPoint: .bottom, endPoint: .top)
        } else {
            return LinearGradient(colors: [
                Color.white.opacity(0.7)
            ], startPoint: .bottom, endPoint: .top)
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "apple.intelligence")
                .foregroundStyle(iconColorGradient)
                .rotationEffect(.degrees(isFocused ? 180 : 0))
            TextField("", text: $text)
                .padding(.horizontal, 12)
                .placeholder(when: text.isEmpty) {
                    Text("What are you looking for?")
                        .font(.title3)
                        .foregroundColor(isFocused ? .black.opacity(0.4) : .white.opacity(0.5))
                        .padding(.horizontal, 12)
                }
                .overlay(alignment: .trailing) {
                    if isFocused {
                        Button {
                            isFocused = false
                            text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                            counter = 0
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        .padding(.horizontal, 8)
                    }
                }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .multilineTextAlignment(.leading)
        .textFieldStyle(.plain)
        .foregroundColor(isFocused ? .black : .white)
        .multilineTextAlignment(.center)
        .font(.title3)
        .background(
            RoundedRectangle(cornerRadius: 32.0, style: .continuous)
                .fill(backgroundGradient)
                .stroke(outlineGradient, lineWidth: isFocused ? 1 : 0)
        )
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .focused($isFocused)
        .onChange(of: isFocused) { _, newValue in
            withAnimation(.easeInOut(duration: 0.9)) {
                state = newValue ? .thinking : .none
                counter+=1
            }
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
