//
//
// ChatsResponse.swift
// interesnoitochka
//
// Created by sturdytea on 23.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct ChatsResponse: Decodable {
    let count: Int
    let chats: [ChatDTO]
}

struct ChatDTO: Decodable {
    let id: Int
    let type: String
    let name: String?
    let avatarURL: String?
    let otherUser: OtherUserDTO
    let lastMessage: LastMessageDTO?

    enum CodingKeys: String, CodingKey {
        case id, type, name
        case avatarURL = "avatar_url"
        case otherUser = "other_user"
        case lastMessage = "last_message"
    }
}

struct OtherUserDTO: Decodable {
    let id: Int
    let name: String?
    let chattingNickname: String
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case chattingNickname = "chatting_nickname"
        case avatarURL = "avatar_url"
    }
}

struct LastMessageDTO: Decodable {
    let content: String?
}

extension ChatDTO {
    func toPreview() -> ChatPreview {
        ChatPreview(
            id: id,
            userId: otherUser.id,
            name: otherUser.name ?? otherUser.chattingNickname,
            username: otherUser.chattingNickname,
            lastMessage: lastMessage?.content ?? "",
            date: Date(), // позже можно брать created_at
            avatarURL: avatarURL.flatMap(URL.init)
        )
    }
}
