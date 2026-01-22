//
//
// MessagesService.swift
// interesnoitochka
//
// Created by sturdytea on 23.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class MessagesService {

    func fetchMessages(
        chatId: Int,
        completion: @escaping (Result<[ChatMessage], Error>) -> Void
    ) {
        let url = URL(
            string: "https://interesnoitochka.ru/api/v1/chats/\(chatId)/messages?offset=0&limit=50"
        )!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(TokenStore.shared.accessToken() ?? "")",
            forHTTPHeaderField: "Authorization"
        )

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let data else { return }

            do {
                let response = try JSONDecoder().decode(MessagesResponse.self, from: data)
                let currentUserId = UserStore.shared.profile?.id ?? 0

                let messages = response.messages.map {
                    $0.toChatMessage(currentUserId: currentUserId)
                }

                completion(.success(messages))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
