import SwiftUI

struct TextInputLayer: View {
    @Binding var state: SiriState
    @State var text: String = "Hello"
    @FocusState private var isFocused: Bool
    
    var body: some View {
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
                    .stroke(Color.white, lineWidth: isFocused ? 2 : 0)
            )
            .padding(16)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .focused($isFocused)
            .onChange(of: isFocused) { _, newValue in
                withAnimation(.easeInOut(duration: 0.9)) {
                    state = newValue ? .thinking : .none
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
