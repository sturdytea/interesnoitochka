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
    
    func searchUsers(
        telegramUsername: String,
        completion: @escaping (Result<[SearchUser], Error>) -> Void
    ) {
        var components = URLComponents(
            string: "https://interesnoitochka.ru/api/v1/users/search"
        )!
        
        components.queryItems = [
            URLQueryItem(name: "telegram_username", value: telegramUsername),
            URLQueryItem(name: "sort_by", value: "telegram_username"),
            URLQueryItem(name: "sort_order", value: "asc"),
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "offset", value: "0")
        ]
        
        let request = URLRequest(url: components.url!)
        
        APIClient.shared.requestWithAutoRefresh(request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder()
                        .decode(SearchUsersResponse.self, from: data)
                    completion(.success(response.items))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
