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
                            .font(.system(size: selectedTab == tab ? 22 : 18, weight: selectedTab == tab ? .bold : .regular))
                        Text(tab.title)
                            .font(.system(size: 10))
                    }
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
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 8)
            .padding()
            .animation(.easeInOut, value: isMenuShowing)
        }
    }
}

#Preview {
    CustomTabView(selectedTab: .constant(.messages), isMenuShowing: .constant(true))
}
