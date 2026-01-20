//
//
// AuthorizationView.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class AuthorizationView: UIView {

    // MARK: - UI

    let illustrationImageView: UIImageView = {
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
        label.text = "Вход в приложение осуществляется\nчерез аккаунт в Telegram"
        label.font = .textL
        label.textColor = .textSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let loginButton = ActionButton(
        title: "Войти в приложение",
        style: .primary
    )
    
    let registerButton = ActionButton(
        title: "Зарегистрироваться",
        style: .secondary
    )

    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "При входе или регистрации вы соглашаетесь\nс нашей Политикой использования"
        label.font = .textS
        label.textColor = .textSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        backgroundColor = .backgroundPrimary
        [
            illustrationImageView,
            titleLabel,
            subtitleLabel,
            loginButton,
            registerButton,
            footerLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func setupLayout() {
        let spacer = UILayoutGuide()
        addLayoutGuide(spacer)
        
        NSLayoutConstraint.activate([

            // Illustration
            illustrationImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            illustrationImageView.topAnchor.constraint(
                greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor,
                constant: 40
            ),
            illustrationImageView.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor,
                constant: -120
            ),

            // Title
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            // Spacer
            spacer.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            spacer.bottomAnchor.constraint(equalTo: loginButton.topAnchor),
            spacer.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),

            // Login button
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            // Register button
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8),
            registerButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),

            // Footer
            footerLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 28),
            footerLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            footerLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            footerLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
