//
//
// ChatsService.swift
// interesnoitochka
//
// Created by sturdytea on 23.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class ChatsService {
    
    func fetchChats(
        isInbox: Bool = true,
        completion: @escaping (Result<[ChatPreview], Error>) -> Void
    ) {
        var components = URLComponents(string: "https://interesnoitochka.ru/api/v1/chats")!
        components.queryItems = [
            .init(name: "is_in_inbox", value: isInbox ? "true" : "false"),
            .init(name: "limit", value: "20"),
            .init(name: "offset", value: "0")
        ]
        
        var request = URLRequest(url: components.url!)
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
                let response = try JSONDecoder().decode(ChatsResponse.self, from: data)
                let previews = response.chats.map { $0.toPreview() }
                completion(.success(previews))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }    
}
