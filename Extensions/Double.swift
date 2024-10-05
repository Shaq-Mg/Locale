//
//  Double.swift
//  Locale
//
//  Created by Shaquille McGregor on 05/10/2024.
//

import Foundation

extension Double {
    private var doubleFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }
    
    func convertToString() -> String {
        return doubleFormatter.string(for: self) ?? ""
    }
}
