//
//  LoginViewModel.swift
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
    
    @Published var loginStatusMessage = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to sign in user:", error)
                self.loginStatusMessage = "Failed to sign in user: \(error)"
                return
            }
            print("Successfully signed in user \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully signed in user \(result?.user.uid ?? "")"
        }
    }
    
    func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                self.loginStatusMessage = "Failed to create user: \(error)"
                return
            }
            
            print("Successfully created user \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user \(result?.user.uid ?? "")"
            self.persistImageToStorage()
        }
    }
    
    private func persistImageToStorage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storage = Storage.storage()
        
        // Create a reference to the location you want to upload the image to
        let storageRef = storage.reference(withPath: uid).child("images/\(UUID().uuidString).jpg")
        guard let imageData = self.selectedImageData else { return }
        // Upload the image data to the reference
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to push image to storage: \(error)")
                self.loginStatusMessage = "Failed to push image to storage: \(error)"
                return
            }
            
            // Get the download URL
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to retrieve download URL: \(error)")
                    self.loginStatusMessage = "Failed to retrieve download URL: \(error)"
                    return
                }
                print("Successfullt stored image with url: \(url?.absoluteString ?? "")")
                self.loginStatusMessage = "Successfullt stored image with url: \(url?.absoluteString ?? "")"
            }
        }
    }
}
