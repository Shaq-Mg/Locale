//
//  MainMessagesView.swift
//  Locale
//
//  Created by Shaquille McGregor on 11/09/2024.
//

import SwiftUI

struct MainMessagesView: View {
    @EnvironmentObject var mainMessagesVM: MainMessagesViewModel
    @State private var chatUser: ChatUser?
    
    var body: some View {
        VStack {
            mainMessagesHeader
            messagesScrollView
            
        }
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .bottomTrailing) {
            Button("+ New message") {
                mainMessagesVM.showNewMessageScreen.toggle()
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.mint)
            .padding()
            .onAppear {
                mainMessagesVM.service.fetchCurrentUser()
            }
            .fullScreenCover(isPresented: $mainMessagesVM.showNewMessageScreen) {
                CreateNewMessageView(didSelectNewUser: { user in
                    print(user.email)
                    self.chatUser = user
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainMessagesView()
            .environmentObject(MainMessagesViewModel(service: FirebaseService()))
    }
}
extension MainMessagesView {
    
    private var mainMessagesHeader: some View {
        HStack(alignment: .center, spacing: 16) {
            AsyncImage(url: URL(string: mainMessagesVM.chatUser?.profileImageUrl ?? "")) { image in
                image
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                    .overlay(Circle().stroke(Color(.label), lineWidth: 2))
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                let email = mainMessagesVM.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "")
                Text(email ?? "email")
                    .font(.system(size: 18, weight: .bold))
            }
            Spacer()
        }
        .padding(8)
        .padding(.leading)
        .background(.ultraThinMaterial)
    }
    
    private var messagesScrollView: some View {
        ScrollView {
            ForEach(mainMessagesVM.recentMessages) { recentMessage in
                VStack {
                    NavigationLink {
                        ChatView(chatUser: chatUser)
                    } label: {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: mainMessagesVM.chatUser?.profileImageUrl ?? "")) { image in
                                image
                                    .scaledToFill()
                                    .frame(width: 34, height: 34)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                                    .overlay(Circle().stroke(Color(.label), lineWidth: 2))
                            } placeholder: {
                                ProgressView()
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.email)
                                    .font(.system(size: 16, weight: .semibold))
                                
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color(.systemGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            Text(recentMessage.timestamp.description)
                                .font(.system(size: 10))
                                .foregroundStyle(.secondary)
                        }
                        .foregroundStyle(Color(.label))
                    }
                    
                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
            }
        }
    }
}
