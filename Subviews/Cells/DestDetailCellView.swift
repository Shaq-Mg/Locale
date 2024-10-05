//
//  DestDetailCellView.swift
//  Locale
//
//  Created by Shaquille McGregor on 04/10/2024.
//

import SwiftUI


struct TravelTypeCell: View {
    let type: TravelType
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: type.imageName)
                .font(.system(size: 25))
            Text(type.description)
                .font(.system(size: 10, weight: .semibold))
        }
        .frame(width: UIScreen.main.bounds.width / 3 - 20, height: 90)
    }
}
