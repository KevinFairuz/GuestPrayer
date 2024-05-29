//
//  Extensions.swift
//  GuestPrayer-IpadOS
//
//  Created by Kevin Fairuz on 20/05/24.
//
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }

}

func createLinearGradientView() -> some View {
    LinearGradient(
        gradient: Gradient(colors: [
            Color(hex: 0x011E37),
            Color(hex: 0x011E37),
            Color(hex: 0x187C89)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    .edgesIgnoringSafeArea(.all)
}
