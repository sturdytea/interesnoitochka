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
    
    private(set) var messages: [ChatMessage] = []
    var onUpdate: (() -> Void)?
    
    func send(text: String) {
        let message = ChatMessage(
            id: UUID(),
            text: text,
            isOutgoing: true,
            date: Date()
        )
        
        messages.append(message)
        onUpdate?()
    }
    
    var isEmpty: Bool {
        messages.isEmpty
    }    
}
