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

    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        bubble.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        bubble.layer.cornerRadius = 20
        bubble.layer.masksToBounds = true

        messageLabel.numberOfLines = 0
        messageLabel.font = .textM

        bubble.addSubview(messageLabel)
        contentView.addSubview(bubble)

        leadingConstraint = bubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        trailingConstraint = bubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)

        NSLayoutConstraint.activate([
            bubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            bubble.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7),

            messageLabel.topAnchor.constraint(equalTo: bubble.topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: bubble.bottomAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: bubble.leadingAnchor, constant: 14),
            messageLabel.trailingAnchor.constraint(equalTo: bubble.trailingAnchor, constant: -14)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        leadingConstraint.isActive = false
        trailingConstraint.isActive = false
    }

    func configure(_ message: ChatMessage, isLastInSequence: Bool) {
        messageLabel.text = message.text

        if message.isOutgoing {
            bubble.backgroundColor = .systemBlue
            messageLabel.textColor = .white

            trailingConstraint.isActive = true
            leadingConstraint.isActive = false

            bubble.layer.maskedCorners = isLastInSequence
            ? [
                .layerMinXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMinYCorner
              ]
            : [
                .layerMinXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMaxXMaxYCorner
              ]

        } else {
            bubble.backgroundColor = .backgroundSecondary
            messageLabel.textColor = .textPrimary

            leadingConstraint.isActive = true
            trailingConstraint.isActive = false

            bubble.layer.maskedCorners = isLastInSequence
            ? [
                .layerMaxXMinYCorner,
                .layerMaxXMaxYCorner,
                .layerMinXMinYCorner
              ]
            : [
                .layerMaxXMinYCorner,
                .layerMaxXMaxYCorner,
                .layerMinXMinYCorner,
                .layerMinXMaxYCorner
              ]
        }
    }
}
