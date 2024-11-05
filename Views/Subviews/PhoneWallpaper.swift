//
//  PhoneBackground.swift
//  SiriAnimationPrototype
//
//  Created by Siddhant Mehta on 2024-06-13.
//

import SwiftUI

struct PhoneWallpaperView: View {
    var body: some View {
        Image("Background", bundle: .main)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(1.2) // avoids clipping
            .ignoresSafeArea()
    }
}

#Preview {
    PhoneWallpaperView()
}
