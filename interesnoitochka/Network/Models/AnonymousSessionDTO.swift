//
//
// AnonymousSessionDTO.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct AnonymousSessionDTO: Decodable {
    let id: String
    let lifetimeMinutes: Int
    let createdAt: String
    let expiresAt: String
    let refreshToken: String?
    let auth: Bool
    let tgId: String?
    let userHashId: String?

    enum CodingKeys: String, CodingKey {
        case id
        case lifetimeMinutes = "lifetime_minutes"
        case createdAt = "created_at"
        case expiresAt = "expires_at"
        case refreshToken = "refresh_token"
        case auth
        case tgId = "tg_id"
        case userHashId = "user_hash_id"
    }
}
