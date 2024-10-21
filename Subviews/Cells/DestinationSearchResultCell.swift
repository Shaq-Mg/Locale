//
//  DestinationSearchResultCell.swift
//  Locale
//
//  Created by Shaquille McGregor on 01/10/2024.
//

import SwiftUI

struct DestinationSearchResultCell: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .foregroundStyle(Color(.systemMint))
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            Divider()
        }
    }
}

#Preview {
    DestinationSearchResultCell(title: "Mcdonalds", subtitle: "123 Broad Street")
}
