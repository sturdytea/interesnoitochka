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
            guard let self else { return }
            
            switch result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                if let networkError = error as? NetworkError,
                   networkError == .unauthorized {
                    self.refreshToken { refreshResult in
                        switch refreshResult {
                        case .success:
                            self.requestWithAutoRefresh(
                                request,
                                completion: completion
                            )
                        case .failure:
                            completion(.failure(NetworkError.unauthorized))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
