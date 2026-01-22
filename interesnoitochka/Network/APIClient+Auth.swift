//
//
// APIClient+Auth.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

extension APIClient {

    func requestWithAutoRefresh(
        _ request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        var request = request

        if let token = TokenStore.shared.accessToken() {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        self.request(request) { [weak self] result in
            switch result {
            case .success(let data):
                completion(.success(data))

            case .failure:
                completion(.failure(NetworkError.invalidResponse))
            }
        }
    }
}
