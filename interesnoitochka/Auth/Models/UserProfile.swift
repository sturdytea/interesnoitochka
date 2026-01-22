//
//
// UserProfile.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

struct UserProfile: Decodable {
    let id: Int
    let name: String
    let chattingNickname: String
    let phone: String?
    let profilePicture: String?
    let email: String?
    let notificationsEnabled: Bool
    let isPro: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case chattingNickname = "chatting_nickname"
        case phone
        case profilePicture = "profile_picture"
        case email
        case notificationsEnabled = "notifications_enabled"
        case isPro = "is_pro"
    }
}
