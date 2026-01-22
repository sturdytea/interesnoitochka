//
//
// ChatViewController.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ChatViewController: UIViewController {
    
    private let contentView = ChatView()
    private let viewModel: ChatViewModel
    
    // MARK: - Init
    
    init(userId: Int, name: String, username: String, avatarURL: URL?) {
        self.viewModel = ChatViewModel(userId: userId, name: name, username: username, avatarURL: avatarURL)
        contentView.titleView.configure(
            name: name,
            username: username,
            avatarURL: avatarURL
        )
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = contentView.titleView
        navigationItem.largeTitleDisplayMode = .never
        contentView.tableView.dataSource = self
        contentView.tableView.register(
            MessageCell.self,
            forCellReuseIdentifier: MessageCell.id
        )
        bind()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let barButton = UIBarButtonItem(
            image: contentView.titleView.backButton,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        ).hideLiquidGlassEffect()
        barButton.width = 16
        navigationItem.leftBarButtonItem = barButton
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func bind() {
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
        contentView.inputViewContainer.onSend = { [weak self] text in
            self?.viewModel.send(text: text)
        }
    }
    
    private func updateUI() {
        contentView.emptyView.isHidden = !viewModel.isEmpty
        contentView.tableView.reloadData()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MessageCell.id,
            for: indexPath
        ) as? MessageCell else {
            return UITableViewCell()
        }
        let message = viewModel.messages[indexPath.row]
        cell.configure(message)
        return cell
    }
}

