//
//
// ChatCell.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ChatCell: UITableViewCell {
    
    static let reuseId = "ChatCell"
    private var isRead: Bool = true
    
    // MARK: - UI
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .none
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1 / UIScreen.main.scale
        image.layer.borderColor = UIColor.graphicNeutral.cgColor
        image.layer.cornerRadius = 24
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .textL
        label.textColor = .textPrimary
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = isRead ? .textM : .textMMedium
        label.textColor = isRead ? .textSecondary : .textPrimary
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .textM
        label.textColor = .textSecondary
        return label
    }()
    
    private lazy var unreadBadge: UILabel = {
        let label = UILabel()
        label.backgroundColor = .backgroundAction
        label.textColor = .textPrimary
        label.font = .textMMedium
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        let messageStack = UIStackView(arrangedSubviews: [
            messageLabel,
            dateLabel
        ])
        messageStack.axis = .horizontal
        messageStack.spacing = 4
        
        let textStack = UIStackView(arrangedSubviews: [
            titleLabel,
            messageStack
        ])
        textStack.axis = .vertical
        textStack.spacing = 4
        
        let rightStack = UIStackView(arrangedSubviews: [
            isRead ? UIView() : unreadBadge
        ])
        rightStack.axis = .vertical
        rightStack.alignment = .trailing
        rightStack.spacing = 6
        
        let mainStack = UIStackView(arrangedSubviews: [
            profileImageView,
            textStack,
            rightStack
        ])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        [
            profileImageView,
            unreadBadge,
            mainStack
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            
            // Unread badge
            unreadBadge.heightAnchor.constraint(equalToConstant: 24),
            unreadBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            
            // Profile image
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
            
            // Main stack
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func configure(with chat: ChatPreview) {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        titleLabel.text = chat.name
        messageLabel.text = chat.lastMessage
        dateLabel.text = "∙ только что"/* + formatter.string(from: chat.date)*/
        isRead = true
        if let url = chat.avatarURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data else { return }
                DispatchQueue.main.async {
                    self?.profileImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
