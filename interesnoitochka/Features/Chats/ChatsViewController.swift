//
//
// ChatsViewController.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ChatsViewController: UIViewController {
    
    private let contentView = ChatsView()
    private let viewModel = ChatsViewModel()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.register(
            ChatCell.self,
            forCellReuseIdentifier: ChatCell.reuseId
        )
        contentView.tableView.dataSource = self
        contentView.tableView.rowHeight = UITableView.automaticDimension
        contentView.tableView.estimatedRowHeight = 72
        contentView.tableView.delegate = self
        contentView.searchView.textField.delegate = self
        if let user = UserStore.shared.profile {
            contentView.configure(with: user)
        }
        bind()
        bindActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reload()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func bind() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.tableView.reloadData()
            }
        }
        viewModel.onUserFound = { [weak self] user in
            DispatchQueue.main.async {
                let avatarURL = user.avatar.flatMap { URL(string: $0) }
                
                let chatViewController = ChatViewController(userId: user.id, name: user.name ?? user.telegramUsername, username: user.telegramUsername, avatarURL: avatarURL)
                self?.navigationController?.pushViewController(chatViewController, animated: true)
            }
        }
        viewModel.onUserNotFound = {
            // пока ничего
            // позже можно alert
        }
    }
    private func bindActions() {
        contentView.searchView.textField.addTarget(
            self,
            action: #selector(searchChanged),
            for: .editingChanged
        )
        
    }
    
    @objc private func searchChanged() {
        let text = contentView.searchView.textField.text ?? ""
        viewModel.search(text)
    }
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = viewModel.chats[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatCell.reuseId,
            for: indexPath
        ) as! ChatCell
        cell.configure(with: chat)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = viewModel.chats[indexPath.row]
        let chatViewController = ChatViewController(
            userId: chat.userId,
            name: chat.name,
            username: chat.username,
            avatarURL: chat.avatarURL
        )
        navigationController?.pushViewController(chatViewController, animated: true)
    }
}

extension ChatsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let query = textField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !query.isEmpty else {
            return false
        }

        textField.resignFirstResponder()
        viewModel.search(query)

        return true
    }
}
