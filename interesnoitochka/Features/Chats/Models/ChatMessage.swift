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
    let id: UUID
    let text: String
    let isOutgoing: Bool   // true → синее справа
    let date: Date
}
