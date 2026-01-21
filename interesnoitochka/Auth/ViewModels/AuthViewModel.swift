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
    private let qrGenerator: QRCodeGenerator
    
    init(
        wsClient: AuthWebSocketClient,
        qrGenerator: QRCodeGenerator
    ) {
        self.wsClient = wsClient
        self.qrGenerator = qrGenerator
    }
    
    func startAuth(
        sessionId: String,
        onShowQR: (UIImage, URL) -> Void,
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
        
        if let qr = qrGenerator.generate(from: urlString) {
            onShowQR(qr, url)
        }
    }
    
    private func telegramAuthURL(sessionId: String) -> String {
        "https://t.me/chatttinnngggbot?start=\(sessionId)"
    }
}

