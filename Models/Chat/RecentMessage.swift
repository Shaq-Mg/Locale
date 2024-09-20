//
//  RecentMessage.swift
//  Locale
//
//  Created by Shaquille McGregor on 20/09/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct RecentMessage: Codable ,Identifiable {
    
    @DocumentID var id: String?
    let text, email, fromId, toId, profileImageUrl: String
    let timestamp: Date
}
