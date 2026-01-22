//
//
// ChatViewModel.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class ChatsViewModel {
    
    private let userService = UserService()
    private let chatsService = ChatsService()
    private(set) var chats: [ChatPreview] = []
    
    var onUserFound: ((SearchUser) -> Void)?
    var onUserNotFound: (() -> Void)?
    var onUpdate: (() -> Void)?
    
    func load() {
        chatsService.fetchChats { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chats):
                    self?.chats = chats
                    ChatsStore.shared.loadChats(chats)
                case .failure:
                    self?.chats = []
                }
                self?.onUpdate?()
            }
        }
    }
    
    func reload() {
        chats = ChatsStore.shared.chats.sorted {
            $0.date > $1.date
        }
        onUpdate?()
    }
    
    func search(_ username: String) {
        userService.searchUsers(telegramUsername: username) { [weak self] result in
            switch result {
            case .success(let users):
                if let user = users.first {
                    self?.onUserFound?(user)
                } else {
                    self?.onUserNotFound?()
                }
                
            case .failure:
                self?.onUserNotFound?()
            }
        }
    }
}
