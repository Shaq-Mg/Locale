//
//  MessageView.swift
//  Locale
//
//  Created by Shaquille McGregor on 18/09/2024.
//

import SwiftUI
import FirebaseAuth

struct MessageView: View {
    let message: ChatMessage
    var body: some View {
        VStack {
            if message.fromId == Auth.auth().currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .background(Color.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundStyle(Color(.label))
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    MessageView(message: ChatMessage.preview)
}
