//
//
// ChatsHeaderView.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ChatsHeaderView: UIView {

    // MARK: - UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .h5
        label.textColor = .textPrimary
        label.textAlignment = .center
        return label
    }()

    lazy var chevronImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.down")
        image.tintColor = .textPrimary
        return image
    }()

    lazy var composeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: "square.and.pencil"),
            for: .normal
        )
        button.tintColor = .textPrimary
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup

    private func setupUI() {
        backgroundColor = .clear
        let titleStack = UIStackView(arrangedSubviews: [
            titleLabel,
            chevronImageView
        ])
        titleStack.axis = .horizontal
        titleStack.spacing = 6
        titleStack.alignment = .center
        [
            composeButton,
            titleStack
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            
            // Title stack
            titleStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleStack.centerYAnchor.constraint(equalTo: centerYAnchor),

            // Compose button
            composeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            composeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            composeButton.widthAnchor.constraint(equalToConstant: 24),
            composeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    // MARK: - Public

    func configure(_ nickname: String) {
        titleLabel.text = nickname
    }
}
