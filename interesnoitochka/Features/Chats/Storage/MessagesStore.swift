//
//
// MessagesStore.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class MessagesStore {
    
    static let shared = MessagesStore()
    private init() {}
    
    private var messagesByUserId: [Int: [ChatMessage]] = [:]
    
    func messages(for userId: Int) -> [ChatMessage] {
        messagesByUserId[userId] ?? []
    }
    
    func append(_ message: ChatMessage, for userId: Int) {
        if messagesByUserId[userId] == nil {
            messagesByUserId[userId] = []
        }
        messagesByUserId[userId]?.append(message)
    }    
}
