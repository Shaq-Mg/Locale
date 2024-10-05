//
//  LocationBackButtonView.swift
//  Locale
//
//  Created by Shaquille McGregor on 04/10/2024.
//

import SwiftUI

struct LocationBackButtonView: View {
    @Binding var mapState: MapState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        HStack {
            Button {
                viewModel.queryFragment = ""
                mapState = .noInput
                viewModel.selectedLocation = nil
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.black)
                    .font(.system(size: 25))
                    .padding(14)
                    .background(Circle().foregroundStyle(.white))
                    .shadow(radius: 8)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    LocationBackButtonView(mapState: .constant(.locationSelected))
        .environmentObject(LocationSearchViewModel())
}
