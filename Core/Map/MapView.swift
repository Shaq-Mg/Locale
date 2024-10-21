//
//  MapView.swift
//  Locale
//
//  Created by Shaquille McGregor on 30/09/2024.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @State private var mapState = MapState.noInput
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                MapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()

                if mapState == .locationSelected {
                    LocationBackButtonView(mapState: $mapState)
                        .padding(.top, 24)
                }
                
                if mapState == .searchingForLocation {
                    SearchDestinationView(mapState: $mapState)
                } else if mapState == .noInput {
                    ShowMenuButtonView(isMenuShowing: $isMenuShowing)
                    SearchBarView(placeholder: "Search destination...")
                        .padding(.top, 64)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .searchingForLocation
                                isMenuShowing = false
                            }
                        }
                }
            }
            
            if mapState == .locationSelected {
                DestinationDetailView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                viewModel.userLocation = location
            }
        }
    }
}

#Preview {
    MapView(isMenuShowing: .constant(false))
        .environmentObject(LocationSearchViewModel())
}
