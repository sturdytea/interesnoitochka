//
//
// AnonymousSessionManager.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

final class AnonymousSessionManager {
    
    static let shared = AnonymousSessionManager()
    
    private let store = SessionStore.shared
    private let service: AnonymousSessionServiceProtocol
    private var currentTask: Task<String, Error>?
    
    private init(
        service: AnonymousSessionServiceProtocol = AnonymousSessionService()
    ) {
        self.service = service
    }
    
    /// Гарантирует, что session_id существует и валиден
    func ensureSessionId() async throws -> String {
        
        if let sessionId = store.sessionId, !store.isExpired {
            return sessionId
        }
        if let task = currentTask {
            return try await task.value
        }
        let task = Task<String, Error> {
            let session = try await service.createSession()
            store.save(sessionId: session.id)
            return session.id
        }
        
        currentTask = task
        
        do {
            let sessionId = try await task.value
            currentTask = nil
            return sessionId
        } catch {
            currentTask = nil
            throw error
        }
    }
}
