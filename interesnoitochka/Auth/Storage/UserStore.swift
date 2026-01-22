//
//
// UserStore.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

final class UserStore {

    static let shared = UserStore()
    private init() {}

    private(set) var profile: UserProfile?

    func save(_ profile: UserProfile) {
        self.profile = profile
        print("Profile saved: \(profile)")
    }

    func clear() {
        profile = nil
    }
}
