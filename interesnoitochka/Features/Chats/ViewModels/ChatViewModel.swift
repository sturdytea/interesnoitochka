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
    private let chatService = ChatService()
    private let chatId: Int
    private let recipientId: Int
    private let name: String
    private let username: String
    private let avatarURL: URL?

    private(set) var messages: [ChatMessage] = []
    var onUpdate: (() -> Void)?
    
    init(
        chatId: Int,
        recipientId: Int,
        name: String,
        username: String,
        avatarURL: URL?
    ) {
        self.chatId = chatId
        self.recipientId = recipientId
        self.name = name
        self.username = username
        self.avatarURL = avatarURL
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
            DispatchQueue.main.async(execute: {
                switch result {
                case .success(let messages):
                    self?.messages = messages
                    self?.onUpdate?()
                case .failure(let error):
                    print(error)
                }
            })
        }
    }

    func send(text: String) {
        let localMessage = ChatMessage(
            id: nil,
            localId: UUID(),
            text: text,
            isOutgoing: true,
            date: Date(),
            status: .sending
        )
        
        messages.append(localMessage)
        onUpdate?()
        
        ChatsStore.shared.upsertChat(
            userId: recipientId,
            name: name,
            username: username,
            message: text,
            date: localMessage.date,
            avatarURL: avatarURL
        )
        
        chatService.sendTextMessage(
            recipientId: recipientId,
            username: username,
            text: text
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
                switch result {
                case .success(let messageId):
                    self.updateMessage(localId: localMessage.localId) {
                        $0.id = messageId
                        $0.status = .sent
                    }
                    
                case .failure:
                    self.updateMessage(localId: localMessage.localId) {
                        $0.status = .failed
                    }
                }
                
                self.onUpdate?()
            }
        }
    }
    
    private func updateMessage(
            localId: UUID,
            update: (inout ChatMessage) -> Void
    ) {
        guard let index = messages.firstIndex(where: { $0.localId == localId }) else { return }
        update(&messages[index])
    }
    
    var isEmpty: Bool {
        messages.isEmpty
    }
}
