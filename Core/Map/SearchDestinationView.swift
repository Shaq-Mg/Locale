//
//  SearchDestinationView.swift
//  Locale
//
//  Created by Shaquille McGregor on 01/10/2024.
//

import SwiftUI

struct SearchDestinationView: View {
    @Binding var showLocationSearchView: Bool
    @EnvironmentObject private var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            VStack {
                searchField
                    .padding(.top, 36)
                Divider()
                    .padding(.vertical, 10)
            }
            .font(.system(size: 16))
            
            ScrollView {
                ForEach(locationViewModel.results, id: \.self) { result in
                    DestinationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                locationViewModel.selectLocation(result)
                                showLocationSearchView.toggle()
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
    SearchDestinationView(showLocationSearchView: .constant(true))
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
                showLocationSearchView.toggle()
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.secondary)
        }
    }
}
