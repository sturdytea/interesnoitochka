//
//
// MessagesResponse.swift
// interesnoitochka
//
// Created by sturdytea on 23.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct MessagesResponse: Decodable {
    let count: Int
    let messages: [MessageDTO]
}

struct MessageDTO: Decodable {
    let id: Int
    let chatId: Int
    let senderId: Int
    let senderName: String
    let senderAvatar: String?
    let content: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case chatId = "chat_id"
        case senderId = "sender_id"
        case senderName = "sender_name"
        case senderAvatar = "sender_avatar"
        case content
        case createdAt = "created_at"
    }
}

extension MessageDTO {
    func toChatMessage(currentUserId: Int) -> ChatMessage {
        ChatMessage(
            id: id,
            text: content,
            isOutgoing: senderId == currentUserId,
            date: ISO8601DateFormatter().date(from: createdAt) ?? Date()
        )
    }
}
