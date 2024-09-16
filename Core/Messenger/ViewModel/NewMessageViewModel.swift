//
//  NewMessageViewModel.swift
//  Locale
//
//  Created by Shaquille McGregor on 15/09/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class NewMessageViewModel: ObservableObject {
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        Firestore.firestore().collection("users").getDocuments { documentSnapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch users: \(error)"
                print("Failed to fetch users: \(error)")
                return
            }
            
            documentSnapshot?.documents.forEach({ snapshot in
                let data = snapshot.data()
                let user = ChatUser(data: data)
                if user.uid != Auth.auth().currentUser?.uid {
                    self.users.append(.init(data: data))
                }
            })
        }
    }
}
