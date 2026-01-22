//
//
// ChatsStore.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class ChatsStore {
    
    static let shared = ChatsStore()
    private init() {}
    
    private(set) var chats: [ChatPreview] = []
    
    func upsertChat(
        userId: Int,
        username: String,
        message: String,
        avatarURL: URL?
    ) {
        let updatedChat = ChatPreview(
            id: chats.first(where: { $0.userId == userId })?.id ?? chats.count + 1,
            userId: userId,
            username: username,
            lastMessage: message,
            date: Date(),
            avatarURL: avatarURL
        )
        
        chats.removeAll { $0.userId == userId }
        chats.insert(updatedChat, at: 0)
    }
}
