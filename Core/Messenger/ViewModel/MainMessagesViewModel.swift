//
//  MainMessagesViewModel.swift
//  Locale
//
//  Created by Shaquille McGregor on 12/09/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class MainMessagesViewModel: ObservableObject {
    @Published var isUserCurrrentlyLoggedOut = true
    @Published var showNewMessageScreen = false
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    let service: FirebaseService
    
    init(service: FirebaseService) {
        self.service = service
        DispatchQueue.main.async {
            self.isUserCurrrentlyLoggedOut = Auth.auth().currentUser?.uid == nil
        }
        service.fetchCurrentUser()
    }
}
