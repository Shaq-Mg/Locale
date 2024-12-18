//
//  FirebaseService.swift
//  Locale
//
//  Created by Shaquille McGregor on 14/09/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseService {
    @Published var isUserCurrrentlyLoggedOut = true
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    static let shared = FirebaseService()
    
    private init() { }
    
    func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
            
            self.chatUser = .init(data: data)
        }
    }
    
    func createAccount() {
        guard let user = chatUser else { return }
        let userData: [String:Any] = [
            FirebaseConstants.uid : user.uid,
            FirebaseConstants.email :  user.email,
            FirebaseConstants.profileImageUrl : user.profileImageUrl
        ]
        
        Firestore.firestore().collection("users").document(user.uid).setData(userData, merge: false)
    }
}
