//
//
// SessionStore.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class SessionStore {

    static let shared = SessionStore()

    private let sessionIdKey = "anonymous_session_id"
    private let createdAtKey = "anonymous_session_created_at"

    private init() {}

    var sessionId: String? {
        UserDefaults.standard.string(forKey: sessionIdKey)
    }

    var createdAt: Date? {
        UserDefaults.standard.object(forKey: createdAtKey) as? Date
    }

    func save(sessionId: String) {
        UserDefaults.standard.set(sessionId, forKey: sessionIdKey)
        UserDefaults.standard.set(Date(), forKey: createdAtKey)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: sessionIdKey)
        UserDefaults.standard.removeObject(forKey: createdAtKey)
    }

    var isExpired: Bool {
        guard let createdAt else { return true }
        return Date().timeIntervalSince(createdAt) > 25 * 60
    }
}
