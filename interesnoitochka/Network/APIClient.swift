//
//
// APIClient.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class APIClient {

    static let shared = APIClient()
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
        session.configuration.timeoutIntervalForRequest = 30
        session.configuration.timeoutIntervalForResource = 60
    }

    func request(
        _ request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidResponse))
                }
                return
            }
            
            if httpResponse.statusCode == 401 {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unauthorized))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.emptyData))
                }
                return
            }

            DispatchQueue.main.async {
                completion(.success(data))
            }
        }

        task.resume()
    }
}

extension APIClient {
    
    func refreshToken(
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let refreshToken = TokenStore.shared.refreshToken() else {
            completion(.failure(NetworkError.unauthorized))
            return
        }
        
        let url = URL(string: "https://interesnoitochka.ru/api/v1/auth/jwt/refresh/new")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.httpBody = "token=\(refreshToken)".data(using: .utf8)
        
        self.request(request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(
                        AuthTokens.self,
                        from: data
                    )
                    
                    let tokens = AuthTokens(
                        accessToken: response.accessToken,
                        refreshToken: response.refreshToken
                    )
                    
                    TokenStore.shared.save(tokens: tokens)
                    completion(.success(()))
                    
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
