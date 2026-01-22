//
//
// UserService.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class UserService {
    
    func fetchMyProfile(
        completion: @escaping (Result<UserProfile, Error>) -> Void
    ) {
        let url = URL(string: "https://interesnoitochka.ru/api/v1/users/my")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        APIClient.shared.requestWithAutoRefresh(request) { result in
            switch result {
            case .success(let data):
                do {
                    let profile = try JSONDecoder().decode(
                        UserProfile.self,
                        from: data
                    )
                    completion(.success(profile))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }    
}
