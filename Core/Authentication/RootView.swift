//
//  RootView.swift
//  Locale
//
//  Created by Shaquille McGregor on 13/09/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isUserCurrrentlyLoggedOut {
                LoginView()
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RootView()
            .environmentObject(AuthViewModel())
    }
}
