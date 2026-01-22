//
//
// ChatService.swift
// interesnoitochka
//
// Created by sturdytea on 23.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class ChatService {

    func sendTextMessage(
        recipientId: Int?,
        username: String?,
        text: String,
        completion: @escaping (Result<Int, Error>) -> Void
    ) {
        var request = URLRequest(
            url: URL(string: "https://interesnoitochka.ru/api/v1/chats/messages")!
        )
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var body: [String: Any] = [
            "content": text,
            "message_type": "text"
        ]

        if let recipientId {
            body["recipient_id"] = recipientId
        }
        if let username {
            body["username"] = username
        }

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        APIClient.shared.requestWithAutoRefresh(request) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    let messageId = json?["message_id"] as? Int
                    completion(.success(messageId ?? 0))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
