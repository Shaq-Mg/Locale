//
//  ChatMessage.swift
//  Locale
//
//  Created by Shaquille McGregor on 18/09/2024.
//

import SwiftUI
import Firebase

struct ChatMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId, fromId, toId, text: String
    
    init(documentId: String, data: [String : Any]) {
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
    }
    
    static let preview = ChatMessage(documentId: "", data: [FirebaseConstants.fromId: "saka@gmail.com", FirebaseConstants.text: "Good morning"])
    
}
