//
//
// ChatNavigationTitleView.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ChatNavigationTitleView: UIView {

    let backButton = UIImage(named: "ChevronLeftIcon")

    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1 / UIScreen.main.scale
        image.layer.borderColor = UIColor.graphicNeutral.cgColor
        image.layer.cornerRadius = 18
        return image
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .textLMedium
        label.textColor = .textPrimary
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .textS
        label.textColor = .textSecondary
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        [
            avatarImageView,
            nameLabel,
            subtitleLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            
            // Avatar
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -16),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 36),
            avatarImageView.heightAnchor.constraint(equalToConstant: 36),

            // Name
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 2),

            // Subtitle
            subtitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).withPriority(.defaultLow),
            
        ])
        setContentHuggingPriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    func configure(
        name: String,
        avatarURL: URL?
    ) {
        nameLabel.text = name
        subtitleLabel.text = "В сети 1 ч. назад" // TODO: Получать актуальное время

        if let url = avatarURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data else { return }
                DispatchQueue.main.async {
                    self?.avatarImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

private extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
