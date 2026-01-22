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

    private let userId: Int
    private let name: String
    private let username: String
    private let avatarURL: URL?

    private(set) var messages: [ChatMessage] = []
    var onUpdate: (() -> Void)?

    init(userId: Int, name: String, username: String, avatarURL: URL?) {
        self.userId = userId
        self.name = name
        self.username = username
        self.avatarURL = avatarURL
        self.messages = MessagesStore.shared.messages(for: userId)
    }

    func send(text: String) {
        let message = ChatMessage(
            id: UUID(),
            text: text,
            isOutgoing: true,
            date: Date()
        )

        MessagesStore.shared.append(message, for: userId)
        ChatsStore.shared.upsertChat(
            userId: userId,
            name: name,
            username: username,
            message: text,
            avatarURL: avatarURL
        )

        messages.append(message)
        onUpdate?()
    }

    var isEmpty: Bool {
        messages.isEmpty
    }
}
