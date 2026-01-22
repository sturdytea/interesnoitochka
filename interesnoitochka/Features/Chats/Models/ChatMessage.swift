//
//
// ChatMessage.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

struct ChatMessage {
    var id: Int?
    let localId: UUID
    let text: String
    let isOutgoing: Bool
    var date: Date
    var status: Status

    enum Status {
        case sending
        case sent
        case failed
    }
}
