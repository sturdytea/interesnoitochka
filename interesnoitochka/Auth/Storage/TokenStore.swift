//
//
// TokenStore.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation
import Security

final class TokenStore {

    static let shared = TokenStore()

    private init() {}

    func save(tokens: AuthTokens) {
        save(key: "access_token", value: tokens.accessToken)
        save(key: "refresh_token", value: tokens.refreshToken)
    }

    func accessToken() -> String? {
        load(key: "access_token")
    }

    func refreshToken() -> String? {
        load(key: "refresh_token")
    }

    func clear() {
        delete(key: "access_token")
        delete(key: "refresh_token")
    }

    // MARK: - Keychain

    private func save(key: String, value: String) {
        delete(key: key)

        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: "com.interesnoitochka.auth",
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemAdd(query as CFDictionary, nil)
    }

    private func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data else { return nil }

        return String(decoding: data, as: UTF8.self)
    }

    private func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        SecItemDelete(query as CFDictionary)
    }
}
