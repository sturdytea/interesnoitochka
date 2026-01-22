//
//
// ChatsView.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ChatsView: UIView {
    
    // MARK: - UI
    
    private lazy var headerView = ChatsHeaderView()
    lazy var searchView = SearchView()
    
    lazy var segmentedView = ChatsSegmentedView()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .clear
        return table
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
        backgroundColor = .backgroundPrimary
        
        let stack = UIStackView(arrangedSubviews: [
            headerView,
            searchView,
            segmentedView
        ])
        stack.axis = .vertical
        stack.spacing = 12
        [
            stack,
            segmentedView,
            headerView,
            searchView,
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(stack)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            // Stack
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            // Table
            tableView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Header
            headerView.heightAnchor.constraint(equalToConstant: 40),
            
            // Search
            searchView.heightAnchor.constraint(equalToConstant: 40),
            
            // Segmented
            segmentedView.heightAnchor.constraint(equalToConstant: 40),

        ])
    }
    
    func configure(with user: UserProfile) {
        headerView.configure(user.chattingNickname)
    }
}
