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
    @Published var messageCount = 0
    @Published var chatMessages = [ChatMessage]()
    
    let chatUser: ChatUser?
    let emptyScrollToId = "Empty"
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        fetchMessages()
    }
    
    private func fetchMessages() {
        guard let fromId = Auth.auth().currentUser?.uid else { return }
        
        guard let toId = chatUser?.uid else { return }
        Firestore.firestore().collection("messages").document(fromId).collection(toId).order(by: "timestamp").addSnapshotListener { querySnapshot, error in
            if let error = error {
                self.errorMessage = "Failed to listen for messages: \(error)"
                print(error)
                return
            }
            
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                }
            })
            
            DispatchQueue.main.async {
                self.messageCount += 1
            }
        }
    }
    
    func handleSend() {
        print(chatText)
        guard let fromId = Auth.auth().currentUser?.uid else { return }
        
        guard let toId = chatUser?.uid else { return }
        
        let document = Firestore.firestore().collection("messages").document(fromId).collection(toId).document()
        
        let messageData = [FirebaseConstants.fromId: fromId, FirebaseConstants.toId: toId, FirebaseConstants.text: chatText, "timestamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into firestore: \(error)"
                return
            }
            print("Successfully saved current user sending message")
            self.chatText = ""
            self.messageCount += 1
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
