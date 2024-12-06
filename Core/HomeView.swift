//
//  HomeView.swift
//  Locale
//
//  Created by Shaquille McGregor on 11/09/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var mainMessagesVM: MainMessagesViewModel
    @EnvironmentObject private var locationVM: LocationSearchViewModel
    @State private var selectedTab: TabState = .messages
    @State private var showMenu = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            if selectedTab == .messages {
                MainMessagesView(isMenuShowing: $showMenu)
                    .environmentObject(mainMessagesVM)
            } else if selectedTab == .map {
                MapView(isMenuShowing: $showMenu)
                    .environmentObject(locationVM)
            } else if selectedTab == .settings {
                NavigationStack {
                    SettingsView(isMenuShowing: $showMenu)
                        .environmentObject(authVM)
                }
            }
            
            if showMenu {
                VStack {
                    Spacer()
                    CustomTabView(selectedTab: $selectedTab, isMenuShowing: $showMenu)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(AuthViewModel())
            .environmentObject(MainMessagesViewModel())
            .environmentObject(LocationSearchViewModel())
    }
}
