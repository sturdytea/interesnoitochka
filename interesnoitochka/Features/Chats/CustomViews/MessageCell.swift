//
//
// MessageCell.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class MessageCell: UITableViewCell {
    
    static let id = "MessageCell"
    
    private let bubble = UIView()
    private let messageLabel = UILabel()
    
    private var leading: NSLayoutConstraint!
    private var trailing: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        
        bubble.layer.cornerRadius = 16
        messageLabel.numberOfLines = 0
        messageLabel.font = .textM
        
        bubble.addSubview(messageLabel)
        contentView.addSubview(bubble)
        
        bubble.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leading = bubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        trailing = bubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            bubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            bubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            bubble.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7),
            
            messageLabel.topAnchor.constraint(equalTo: bubble.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: bubble.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: bubble.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: bubble.trailingAnchor, constant: -12)
        ])
    }
    
    func configure(_ message: ChatMessage) {
        messageLabel.text = message.text
        
        if message.isOutgoing {
            bubble.backgroundColor = .systemBlue
            messageLabel.textColor = .white
            leading.isActive = false
            trailing.isActive = true
        } else {
            bubble.backgroundColor = .backgroundSecondary
            messageLabel.textColor = .textPrimary
            trailing.isActive = false
            leading.isActive = true
        }
    }    
}
