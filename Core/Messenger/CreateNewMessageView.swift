//
//  CreateNewMessageView.swift
//  Locale
//
//  Created by Shaquille McGregor on 15/09/2024.
//

import SwiftUI

struct CreateNewMessageView: View {
    @ObservedObject var messageViewModel = NewMessageViewModel()
    @Environment(\.dismiss) private var dismiss
    let didSelectNewUser: (ChatUser) -> ()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(messageViewModel.errorMessage)
                ForEach(messageViewModel.users) { user in
                    NavigationLink {
                        ChatView(chatUser: user)
                    } label: {
                        NewMessageSection(user: user)
                    }
                    Divider()
                        .padding(.vertical, 6)
                }
            }
            .navigationTitle("New Message")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateNewMessageView(didSelectNewUser: { _ in })
    }
}

struct NewMessageSection: View {
    let user: ChatUser
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: user.profileImageUrl)) { image in
                image
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                    .overlay(Circle().stroke(Color(.label), lineWidth: 2))
            } placeholder: {
                ProgressView()
            }
            
            Text(user.email)
                .font(.headline)
                .foregroundStyle(Color(.label))
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
