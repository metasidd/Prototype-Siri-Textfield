import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("Background", bundle: .main)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(1.2)
            .ignoresSafeArea()
    }
} 
