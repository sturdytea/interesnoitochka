//
//
// AnonymousSessionServiceProtocol.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

protocol AnonymousSessionServiceProtocol {
    func createSession() async throws -> AnonymousSessionDTO
}

final class AnonymousSessionService: AnonymousSessionServiceProtocol {

    private let baseURL = URL(string: "https://interesnoitochka.ru")!
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func createSession() async throws -> AnonymousSessionDTO {
        let url = baseURL.appendingPathComponent("/api/v1/auth/sessions/new")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(AnonymousSessionDTO.self, from: data)
    }
}
