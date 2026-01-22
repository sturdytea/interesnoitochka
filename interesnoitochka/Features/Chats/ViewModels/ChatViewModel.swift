//
//
// ChatViewModel.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class ChatViewModel {

    private let messagesService = MessagesService()
    private let chatId: Int

    private(set) var messages: [ChatMessage] = []
    var onUpdate: (() -> Void)?
    
    init(chatId: Int) {
        self.chatId = chatId
    }

    func loadMessages() {
        messagesService.fetchMessages(chatId: chatId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let messages):
                    self?.messages = messages
                case .failure:
                    self?.messages = []
                }
                self?.onUpdate?()
            }
        }
    }

    func send(text: String) {
//        let message = ChatMessage(
//            id: UUID(),
//            text: text,
//            isOutgoing: true,
//            date: Date()
//        )
//
//        MessagesStore.shared.append(message, for: userId)
//        ChatsStore.shared.upsertChat(
//            userId: userId,
//            name: name,
//            username: username,
//            message: text,
//            avatarURL: avatarURL
//        )
//
//        messages.append(message)
//        onUpdate?()
    }

    var isEmpty: Bool {
        messages.isEmpty
    }
}
