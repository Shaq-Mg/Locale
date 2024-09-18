//
//  ChatView.swift
//  Locale
//
//  Created by Shaquille McGregor on 15/09/2024.
//

import SwiftUI
import FirebaseAuth

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
    
    static let emptyScrollToId = "Empty"
    
    private var messagesView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                ForEach(viewModel.chatMessages) { message in
                    MessageView(message: message)
                }
                
                HStack { Spacer() }
                    .id(viewModel.emptyScrollToId)
                    .onReceive(viewModel.$messageCount) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            scrollViewProxy.scrollTo(viewModel.emptyScrollToId, anchor: .bottom)
                        }
                    }
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
