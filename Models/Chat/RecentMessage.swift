//
//  RecentMessage.swift
//  Locale
//
//  Created by Shaquille McGregor on 20/09/2024.
//

import SwiftUI
import Firebase

struct RecentMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId, text, email, fromId, toId, profileImageUrl: String
    let timestamp: Timestamp
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.text = data["text"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.profileImageUrl = data["profile_image_url"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
