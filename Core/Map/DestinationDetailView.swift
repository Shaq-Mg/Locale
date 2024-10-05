//
//  DestinationDetailView.swift
//  Locale
//
//  Created by Shaquille McGregor on 04/10/2024.
//

import SwiftUI

struct DestinationDetailView: View {
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @State private var selectedTravelType: TravelType = .walk
    var body: some View {
        VStack(spacing: 14) {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 14)
            
            VStack(alignment: .leading) {
                HStack {
                    LocationInputView(text: "Current time", fontSize: 16, color: .secondary)
                    Spacer()
                    LocationInputView(text: locationViewModel.currentTime ?? "", fontSize: 14, color: .secondary)
                }
                .padding(.vertical, 10)
                
                HStack {
                    if let location = locationViewModel.selectedLocation {
                        Text(location.title)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    Spacer()
                    LocationInputView(text: locationViewModel.estDestinationTime ?? "", fontSize: 14, color: .secondary)
                }
            }
            Divider()
                .padding(.bottom, 14)
            
            LocationInputView(text: "Travel type", fontSize: 18, color: .secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                travelTypeSection
            }
            if let destination = locationViewModel.selectedLocation, let destTime = locationViewModel.estDestinationTime {
                Text("Estimated time to arrive at \(destination.title) is at \(destTime).")
                    .padding(.top)
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
            }
            
            Button("Confirm") {
                
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(8)
            .shadow(radius: 8)
            .padding(.top, 64)
            
        }
        .padding(.horizontal)
        .padding(.bottom, 44)
        .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.white))
    }
}

#Preview {
    DestinationDetailView()
        .environmentObject(LocationSearchViewModel())
}

extension DestinationDetailView {
    
    private var travelTypeSection: some View {
        HStack(spacing: 12) {
            ForEach(TravelType.allCases) { type in
                VStack {
                    TravelCellView(type: type)
                        .foregroundStyle(type == selectedTravelType ? .white : .black)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color(type == selectedTravelType ? .systemBlue : .systemGroupedBackground)))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedTravelType = type
                            }
                        }
                    if type == selectedTravelType {
                        withAnimation(.spring()) {
                            Text("20 mins")
                                .font(.system(size: 12, weight: .semibold))
                        }
                    } else {
                        Text("")
                    }
                }
            }
        }
    }
}
