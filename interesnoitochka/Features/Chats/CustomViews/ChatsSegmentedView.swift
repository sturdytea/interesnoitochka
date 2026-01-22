//
//
// ChatsSegmentedView.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ChatsSegmentedView: UIView {
    
    enum Tab {
        case messages
        case archive
    }
    
    var onTabChanged: ((Tab) -> Void)?
    private(set) var selectedTab: Tab = .messages
    
    // MARK: - UI
    
    lazy var messagesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сообщения", for: .normal)
        button.titleLabel?.font = .textLMedium
        button.setTitleColor(.textPrimary, for: .normal)
        return button
    }()
    
    lazy var archiveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Архив", for: .normal)
        button.titleLabel?.font = .textLMedium
        button.setTitleColor(.textSecondary, for: .normal)
        return button
    }()
    
    private let unreadDot: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
        view.isHidden = false
        return view
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .textPrimary
        return view
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
        
        let stack = UIStackView(arrangedSubviews: [
            messagesButton,
            archiveButton
        ])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.alignment = .center
        [
            stack,
            indicatorView,
            unreadDot
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.heightAnchor.constraint(equalToConstant: 40),
            
            indicatorView.topAnchor.constraint(equalTo: stack.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 1.5),
            indicatorView.trailingAnchor.constraint(equalTo: messagesButton.trailingAnchor, constant: 8),
            indicatorView.leadingAnchor.constraint(equalTo: messagesButton.leadingAnchor, constant: -8),
            
            unreadDot.widthAnchor.constraint(equalToConstant: 6),
            unreadDot.heightAnchor.constraint(equalToConstant: 6),
            unreadDot.leadingAnchor.constraint(equalTo: archiveButton.trailingAnchor, constant: 4),
            unreadDot.centerYAnchor.constraint(equalTo: archiveButton.centerYAnchor)
        ])
        
        messagesButton.addTarget(self, action: #selector(messagesTapped), for: .touchUpInside)
        archiveButton.addTarget(self, action: #selector(archiveTapped), for: .touchUpInside)
    }
    
    @objc private func messagesTapped() {
        setTab(.messages)
        onTabChanged?(.messages)
    }

    @objc private func archiveTapped() {
        setTab(.archive)
        onTabChanged?(.archive)
    }
    
    func setTab(_ tab: Tab, animated: Bool = true) {
        selectedTab = tab
        
        messagesButton.setTitleColor(
            tab == .messages ? .textPrimary : .textSecondary,
            for: .normal
        )
        archiveButton.setTitleColor(
            tab == .archive ? .textPrimary : .textSecondary,
            for: .normal
        )
        
        let targetButton = tab == .messages ? messagesButton : archiveButton
        
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.indicatorView.frame.origin.x = targetButton.frame.origin.x
            self.indicatorView.frame.size.width = targetButton.frame.width
        }
    }
}
