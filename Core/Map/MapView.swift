//
//  MapView.swift
//  Locale
//
//  Created by Shaquille McGregor on 30/09/2024.
//

import SwiftUI

struct MapView: View {
    @State private var showLocationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresentable()
                .ignoresSafeArea()
            
            if showLocationSearchView {
                SearchDestinationView(showLocationSearchView: $showLocationSearchView)
            } else {
                SearchBarView(placeholder: "Search destination...")
                    .padding(.top, 64)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showLocationSearchView.toggle()
                        }
                    }
            }
        }
    }
}

#Preview {
    MapView()
}
