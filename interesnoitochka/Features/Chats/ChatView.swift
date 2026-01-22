//
//
// ChatView.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ChatView: UIView {

    // MARK: - UI
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        return table
    }()
    
    lazy var inputViewContainer = MessageInputView()
    lazy var emptyView = EmptyChatView()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .backgroundPrimary
        [
            tableView,
            emptyView,
            inputViewContainer
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            
            // Input
            inputViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputViewContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            inputViewContainer.heightAnchor.constraint(equalToConstant: 56),

            // Table view
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputViewContainer.topAnchor),

            // Empty chat
            emptyView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
