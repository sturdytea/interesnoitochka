//
//
// SearchView.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class SearchView: UIView {
    
    // MARK: - UI
    
    let containerView = UIView()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: [
                .foregroundColor: UIColor.textSecondary
            ]
        )
        textField.font = .textM
        textField.textColor = .textPrimary
        textField.tintColor = .textPrimary
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var searchIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")
        image.tintColor = .textSecondary
        return image
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(named: "FilterIcon"),
            for: .normal
        )
        button.tintColor = .textSecondary
        button.backgroundColor = .backgroundSecondary
        button.layer.cornerRadius = 8
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
        containerView.backgroundColor = .backgroundSecondary
        containerView.layer.cornerRadius = 8
        let leftStack = UIStackView(arrangedSubviews: [
            searchIcon,
            textField
        ])
        leftStack.axis = .horizontal
        leftStack.spacing = 8
        leftStack.alignment = .center
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.addSubview(leftStack)
        addSubview(filterButton)
        [
            containerView,
            textField,
            searchIcon,
            filterButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            // Container
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Filter button
            filterButton.leadingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: 8
            ),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterButton.widthAnchor.constraint(equalToConstant: 40),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Left stack
            leftStack.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 12
            ),
            leftStack.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -12
            ),
            leftStack.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 10
            ),
            leftStack.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -10
            ),
            
            // Search icon
            searchIcon.widthAnchor.constraint(equalToConstant: 16),
            searchIcon.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
