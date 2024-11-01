import SwiftUI

struct TextInputLayer: View {
    @Binding var state: SiriState
    @Binding var counter: Int
    
    @State var text: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField("", text: $text)
            .padding(.horizontal, 12)
            .placeholder(when: text.isEmpty) {
                Text("What are you looking for?")
                    .foregroundColor(isFocused ? .black.opacity(0.7) : .white.opacity(0.5))
                    .padding(.horizontal, 12)
            }
            .overlay(alignment: .trailing) {
                if isFocused {
                    Button {
                        isFocused = false
                        counter = 0
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    .padding(.horizontal, 8)
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
            .multilineTextAlignment(.leading)
            .textFieldStyle(.plain)
            .foregroundColor(isFocused ? .black : .white)
            .multilineTextAlignment(.center)
            .font(.title3)
            .background(
                RoundedRectangle(cornerRadius: 32.0, style: .continuous)
                    .fill(isFocused ? Color.white.opacity(0.7) : Color.gray.opacity(0.1))
                    .stroke(Color.white, lineWidth: isFocused ? 1 : 0)
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
