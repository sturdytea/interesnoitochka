//
//
// AuthWebSocketClient.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class AuthWebSocketClient {

    private var task: URLSessionWebSocketTask?
    private let session: URLSession = .shared

    func connect(
        sessionId: String,
        onTokens: @escaping (AuthTokens) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        let urlString = "wss://interesnoitochka.ru/api/v1/ws/ws/session/\(sessionId)"
        guard let url = URL(string: urlString) else { return }

        task = session.webSocketTask(with: url)
        task?.resume()

        listen(onTokens: onTokens, onError: onError)
    }

    func disconnect() {
        task?.cancel(with: .normalClosure, reason: nil)
        task = nil
    }

    private func listen(
        onTokens: @escaping (AuthTokens) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        task?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                onError(error)

            case .success(let message):
                self?.handle(message, onTokens: onTokens, onError: onError)
            }
        }
    }

    private func handle(
        _ message: URLSessionWebSocketTask.Message,
        onTokens: @escaping (AuthTokens) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        let data: Data?

        switch message {
        case .string(let text):
            data = text.data(using: .utf8)
        case .data(let rawData):
            data = rawData
        @unknown default:
            data = nil
        }

        guard let data else {
            listen(onTokens: onTokens, onError: onError)
            return
        }

        do {
            let tokens = try JSONDecoder().decode(AuthTokens.self, from: data)
            TokenStore.shared.save(tokens: tokens)
            disconnect()
            onTokens(tokens)
            print("✅ AUTH SUCCESS")
            print("🔑 Access token:", tokens.accessToken)
            print("🔄 Refresh token:", tokens.refreshToken)
        } catch {
            // пришло не сообщение с токенами — продолжаем слушать
            listen(onTokens: onTokens, onError: onError)
        }
    }
}
