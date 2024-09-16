//
//  AuthViewModel.swift
//  Locale
//
//  Created by Shaquille McGregor on 13/09/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import PhotosUI

final class AuthViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    
    @Published var isUserCurrrentlyLoggedOut = true
    @Published var errorMessage = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    let service: FirebaseService
    
    init(service: FirebaseService) {
        self.service = service
        DispatchQueue.main.async {
            self.isUserCurrrentlyLoggedOut = Auth.auth().currentUser?.uid == nil
        }
    }
    
    func clearLoginInformation() {
        email = ""
        password = ""
        confirmPassword = ""
        errorMessage = ""
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to sign in user:", error)
                self.errorMessage = "Failed to sign in user: \(error)"
                return
            }
            print("Successfully signed in user \(result?.user.uid ?? "")")
            self.errorMessage = "Successfully signed in user \(result?.user.uid ?? "")"
            self.isUserCurrrentlyLoggedOut = false
        }
    }
    
    func createNewAccount() {
        if self.selectedImageData == nil {
            self.errorMessage = "You must select an profile image"
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                self.errorMessage = "Failed to create user: \(error)"
                return
            }
            
            print("Successfully created user \(result?.user.uid ?? "")")
            self.errorMessage = "Successfully created user \(result?.user.uid ?? "")"
            self.persistImageToStorage()
            self.isUserCurrrentlyLoggedOut = false
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        isUserCurrrentlyLoggedOut = true
    }
    
    func persistImageToStorage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storage = Storage.storage()
        
        // Create a reference to the location you want to upload the image to
        let storageRef = storage.reference(withPath: uid).child("images/\(UUID().uuidString).jpg")
        guard let imageData = self.selectedImageData else { return }
        // Upload the image data to the reference
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to push image to storage: \(error)")
                self.errorMessage = "Failed to push image to storage: \(error)"
                return
            }
            
            // Get the download URL
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to retrieve download URL: \(error)")
                    self.errorMessage = "Failed to retrieve download URL: \(error)"
                    return
                }
                print("Successfullt stored image with url: \(url?.absoluteString ?? "")")
                self.errorMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                
                guard let url = url else { return }
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    private func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        Firestore.firestore().collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print(error)
                self.errorMessage = "\(error)"
                return
            }
            print("Success")
        }
    }
}
