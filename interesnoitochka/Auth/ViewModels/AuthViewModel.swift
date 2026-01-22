//
//
// AuthViewModel.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class AuthViewModel {
    
    private let wsClient: AuthWebSocketClient
    
    init(wsClient: AuthWebSocketClient) {
        self.wsClient = wsClient
    }
    
    func startAuth(
        sessionId: String,
        onFormURL: (URL) -> Void,
        onAuthorized: @escaping (AuthTokens) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        wsClient.connect(
            sessionId: sessionId,
            onTokens: onAuthorized,
            onError: onError
        )
        let urlString = telegramAuthURL(sessionId: sessionId)
        guard let url = URL(string: urlString) else { return }
        onFormURL(url)
    }
    
    private func telegramAuthURL(sessionId: String) -> String {
        "https://t.me/chatttinnngggbot?start=\(sessionId)"
    }
    
    func loadProfileAndFinishAuth(completion: @escaping (UserProfile) -> Void) {
        UserService().fetchMyProfile { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    UserStore.shared.save(profile)
                    completion(profile)
                case .failure(let error):
                    print("❌ Failed to load profile:", error)
                }
            }
        }
    }
}

