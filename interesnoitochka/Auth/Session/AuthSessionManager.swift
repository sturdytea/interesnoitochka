//
//
// AuthSessionManager.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class AuthSessionManager {
    
    static let shared = AuthSessionManager()
    
    private let anonymousManager = AnonymousSessionManager.shared
    private let webSocketClient = AuthWebSocketClient()
    
    private init() {}
    
    func startLogin(
        onSessionCreated: @escaping (String) -> Void,
        onAuthorized: @escaping () -> Void,
        onError: @escaping (Error) -> Void
        
    ) {
        Task {
            do {
                let sessionId = try await anonymousManager.ensureSessionId()
                
                // 1️⃣ Immediately return sessionId so UI can show QR
                onSessionCreated(sessionId)
                
                // 2️⃣ Start listening for Telegram authorization via WebSocket
                
                webSocketClient.connect(
                    sessionId: sessionId,
                    onTokens: { _ in
                        onAuthorized()
                    },
                    onError: onError
                )
            } catch {
                onError(error)
            }
        }
    }
}
