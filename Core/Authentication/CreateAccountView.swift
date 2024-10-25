//
//  CreateAccountView.swift
//  Locale
//
//  Created by Shaquille McGregor on 13/09/2024.
//

import SwiftUI
import PhotosUI

struct CreateAccountView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            photoPickerSection
            
            InputView(text: $authViewModel.email, placeholder: "Email")
            InputView(text: $authViewModel.password, placeholder: "Password", isSecureField: true)
            InputView(text: $authViewModel.confirmPassword, placeholder: "Confirm password", isSecureField: true)
            
            Text(authViewModel.errorMessage)
                .foregroundStyle(.red)
                .padding()
            
            Button("Create account") {
                authViewModel.createNewAccount()
            }
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.mint)
            .cornerRadius(8)
            .padding(.vertical)
            
            Button("Already have a existing account? login") {
                dismiss()
            }
            .foregroundStyle(.black)
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Create account")
        .navigationBarBackButtonHidden(true)
        .onAppear { authViewModel.clearLoginInformation() }
        .onChange(of: authViewModel.selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    authViewModel.selectedImageData = data
                    
                    authViewModel.persistImageToStorage()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateAccountView()
            .environmentObject(AuthViewModel())
    }
}

extension CreateAccountView {
    private var photoPickerSection: some View {
        PhotosPicker(selection: $authViewModel.selectedItem, matching: .images, photoLibrary: .shared()) {
            if let selectedImage = authViewModel.selectedImageData,
               let uiImage = UIImage(data: selectedImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(radius: 5)
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(Color(.systemGray))
            }
        }
        .frame(width: 200, height: 200)
    }
}
