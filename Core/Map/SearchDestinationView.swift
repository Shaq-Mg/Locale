//
//  SearchDestinationView.swift
//  Locale
//
//  Created by Shaquille McGregor on 01/10/2024.
//

import SwiftUI

struct SearchDestinationView: View {
    @Binding var mapState: MapState
    @EnvironmentObject private var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            searchField
                .padding(.top, 36)
            Divider()
                .padding(.vertical, 10)
            
            HStack {
                Text(locationViewModel.queryFragment.isEmpty ? "Recent" : "Results")
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: locationViewModel.queryFragment.isEmpty ? "info.circle.fill" : "chevron.down")
            }
            .font(.system(size: 16))
            
            ScrollView {
                ForEach(locationViewModel.results, id: \.self) { result in
                    DestinationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                locationViewModel.selectLocation(result)
                                mapState = .locationSelected
                            }
                        }
                }
            }
        }
        .padding(.horizontal)
        .cornerRadius(20)
        .background(.white)
    }
}

#Preview {
    SearchDestinationView(mapState: .constant(.searchingForLocation))
        .environmentObject(LocationSearchViewModel())
}

extension SearchDestinationView {
    private var searchField: some View {
        HStack(spacing: 14) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.black)
                    .padding(.leading)
                TextField("Search destination...", text: $locationViewModel.queryFragment)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.vertical, 8)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2))
            .foregroundStyle(.secondary)
            .background(.white)
            Button("Cancel") {
                locationViewModel.queryFragment = ""
                mapState = .noInput
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.secondary)
        }
    }
}
