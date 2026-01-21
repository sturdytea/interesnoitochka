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
        contentView.configure()
        bind()
        viewModel.load()
    }
    
    private func bind() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.tableView.reloadData()
            }
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

extension ChatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.chats.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatCell.reuseId,
            for: indexPath
        ) as! ChatCell
        
        cell.configure(with: viewModel.chats[indexPath.row])
        return cell
    }
}
