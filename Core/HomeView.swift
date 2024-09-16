//
//  HomeView.swift
//  Locale
//
//  Created by Shaquille McGregor on 11/09/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        Button(action: {
            try? authViewModel.signOut()
        }, label: {
            Image(systemName: "gear")
        })
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(AuthViewModel(service: FirebaseService()))
    }
}
