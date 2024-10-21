//
//  TabState.swift
//  Locale
//
//  Created by Shaquille McGregor on 18/10/2024.
//

import Foundation

enum TabState: Int, CaseIterable {
    case messages
    case map
    case settings
    
    var title: String {
        switch self {
        case .messages: return "Messages"
        case .map: return "Map"
        case .settings: return "Settings"
            
        }
    }
    
    var imageName: String {
        switch self {
        case .messages: return "paperplane"
        case .map: return "mappin"
        case .settings: return "gear"
            
        }
    }
}

extension TabState: Identifiable {
    var id: Int { return self.rawValue }
}
