//
//  ChatView.swift
//  Locale
//
//  Created by Shaquille McGregor on 15/09/2024.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject private var viewModel: ChatViewModel
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.viewModel = .init(chatUser: chatUser)
        self.chatUser = chatUser
    }
    
    var body: some View {
        VStack {
            messagesView
            
            chatBottomBar
        }
        .navigationTitle(chatUser?.email ?? "user")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    AsyncImage(url: URL(string: chatUser?.profileImageUrl ?? "")) { image in
                        image
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                            .overlay(Circle().stroke(Color(.label), lineWidth: 2))
                    } placeholder: {
                        ProgressView()
                    }
                    
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatView(chatUser: ChatUser .init(data: ["email": "saka@gmail.com"]))
    }
}

extension ChatView {
    private var messagesView: some View {
        ScrollView {
            ForEach(0..<10) { num in
                HStack {
                    Spacer()
                    HStack {
                        Text("Recent message")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(Color.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
        .padding(.bottom)
    }
    
    private var chatBottomBar: some View {
        HStack {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 20, weight: .semibold))
            TextField("Send a message...", text: $viewModel.chatText)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .padding(.leading)
                .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.secondary.opacity(0.1)))
            Button {
                viewModel.handleSend()
            } label: {
                Image(systemName: "paperplane")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.mint)
            }
        }
        .padding(.horizontal)
    }
}
