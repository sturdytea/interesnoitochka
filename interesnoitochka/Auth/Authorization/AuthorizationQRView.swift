//
//
// AuthorizationQRView.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class AuthorizationQRView: UIView {
    
    // MARK: - UI
    
    let qrImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AuthorizationImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход в учетную запись"
        label.font = .h4
        label.textColor = .textPrimary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отсканируйте камерой телефона для быстрого входа"
        label.font = .textL
        label.textColor = .textSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let telegramButton = ActionButton(
        title: "Войти в Telegram",
        style: .primary
    )
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .backgroundSecondary
        
        activityIndicator.hidesWhenStopped = true
        
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            qrImageView,
            activityIndicator,
            telegramButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // Stack
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // QR
            qrImageView.widthAnchor.constraint(equalToConstant: 220),
            qrImageView.heightAnchor.constraint(equalToConstant: 220),
            
            // Telegram button
            telegramButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            telegramButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func showLoading(_ loading: Bool) {
        loading ? activityIndicator.startAnimating()
        : activityIndicator.stopAnimating()
    }
}
