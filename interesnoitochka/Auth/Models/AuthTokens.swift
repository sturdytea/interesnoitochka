//
//
// AuthTokens.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct AuthTokens: Decodable {
    let accessToken: String
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
