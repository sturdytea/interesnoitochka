//
//
// SearchUsersResponse.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct SearchUsersResponse: Decodable {
    let items: [SearchUser]
}

struct SearchUser: Decodable {
    let id: Int
    let name: String?
    let telegramUsername: String
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case telegramUsername = "telegram_username"
        case avatar
    }
}
