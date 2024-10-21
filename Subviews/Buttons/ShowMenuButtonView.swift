//
//  ShowMenuButtonView.swift
//  Locale
//
//  Created by Shaquille McGregor on 19/10/2024.
//

import SwiftUI

struct ShowMenuButtonView: View {
    @Binding var isMenuShowing: Bool
    var body: some View {
        HStack {
            Button {
                isMenuShowing.toggle()
            } label: {
                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(.black)
                    .font(.system(size: 22))
                    .padding(14)
                    .background(Circle().foregroundStyle(.white))
                    .shadow(radius: 10)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    ShowMenuButtonView(isMenuShowing: .constant(false))
}
