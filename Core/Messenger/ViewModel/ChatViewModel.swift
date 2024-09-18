//
//  ChatViewModel.swift
//  Locale
//
//  Created by Shaquille McGregor on 16/09/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

final class ChatViewModel: ObservableObject {
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
    }
    
    func handleSend() {
        print(chatText)
        guard let fromId = Auth.auth().currentUser?.uid else { return }
        
        guard let toId = chatUser?.uid else { return }
        
        let document = Firestore.firestore().collection("messages").document(fromId).collection(toId).document()
        
        let messageData = ["fromId": fromId, "toId": toId, "text": chatText, "timestamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into firestore: \(error)"
                return
            }
            print("Successfully saved current user sending message")
            self.chatText = ""
        }
        
        let recipientMessageDocument = Firestore.firestore().collection("messages").document(toId).collection(fromId).document()
        
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into firestore: \(error)"
                return
            }
            print("Recipient message successfully saved as well 🥳")
        }
    }
}
