//
//  TravelType.swift
//  Locale
//
//  Created by Shaquille McGregor on 04/10/2024.
//

import Foundation

enum TravelType: Int, CaseIterable, Identifiable {
    case walk
    case drive
    case cycle
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .walk: return "Walk"
        case .drive: return "Drive"
        case .cycle: return "Cycle"
            
        }
    }
    
    var imageName: String {
        switch self {
        case .walk: return "figure.walk"
        case .drive: return "car.fill"
        case .cycle: return "bicycle"
            
        }
    }
    
    var distance: Double {
        switch self {
        case .walk: return 18
        case .drive: return 3
        case .cycle: return 6
            
        }
    }
    
    func computeTime(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        
        switch self {
        case .walk: return distanceInMiles * distance
        case .drive: return distanceInMiles * distance
        case .cycle: return distanceInMiles * distance + 1
            
        }
    }
}
