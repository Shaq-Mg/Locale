//
//  LocationInputView.swift
//  Locale
//
//  Created by Shaquille McGregor on 04/10/2024.
//

import SwiftUI

struct LocationInputView: View {
    let text: String
    let fontSize: CGFloat
    let color: Color
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .semibold))
            .foregroundStyle(color)
    }
}

#Preview {
    LocationInputView(text: "Current location", fontSize: 12, color: .secondary)
}
