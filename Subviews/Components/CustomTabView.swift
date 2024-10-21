//
//  CustomTabView.swift
//  Locale
//
//  Created by Shaquille McGregor on 18/10/2024.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: TabState
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        VStack {
            HStack {
                ForEach(TabState.allCases) { tab in
                    Spacer()
                    VStack(spacing: 3) {
                        Image(systemName: tab.imageName)
                            .font(.system(size: selectedTab == tab ? 20 : 18, weight: selectedTab == tab ? .bold : .regular))
                        Text(tab.title)
                            .font(.system(size: 10))
                    }
                    .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                    .foregroundStyle(selectedTab == tab ? .mint : .black)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedTab = tab
                            isMenuShowing = false
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .secondary, radius: 4, x: 2, y: 4)
            .padding()
            .animation(.easeInOut, value: isMenuShowing)
        }
    }
}

#Preview {
    CustomTabView(selectedTab: .constant(.messages), isMenuShowing: .constant(true))
}
