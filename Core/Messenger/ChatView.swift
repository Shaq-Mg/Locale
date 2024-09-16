//
//  ChatView.swift
//  Locale
//
//  Created by Shaquille McGregor on 15/09/2024.
//

import SwiftUI

struct ChatView: View {
    @State private var chatText = ""
    let chatUser: ChatUser?
    
    var body: some View {
        VStack {
            messagesView
            
            chatBottomBar
        }
        .navigationTitle(chatUser?.email ?? "user")
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
            TextField("Send a message...", text: $chatText)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .padding(.leading)
                .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.secondary.opacity(0.1)))
            Button {
                
            } label: {
                Image(systemName: "paperplane")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.mint)
            }
        }
        .padding(.horizontal)
    }
}
