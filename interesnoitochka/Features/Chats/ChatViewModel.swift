//
//
// ChatViewModel.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

final class ChatsViewModel {
    
    private(set) var chats: [ChatPreview] = []
    
    var onUpdate: (() -> Void)?
    
    func load() {
        // TODO: Replace this mock 
        // ВРЕМЕННО, чтобы проверить UI
        chats = [
            ChatPreview(
                id: "1",
                title: "test_chat",
                lastMessage: "Hello 👋",
                dateText: "now",
                avatarURL: nil,
                unreadCount: 2,
                isOnline: true,
                isVerified: false
            )
        ]
        
        onUpdate?()
    }
    
    func search(_: String) {
        // TODO: Implement logic
    }
}
