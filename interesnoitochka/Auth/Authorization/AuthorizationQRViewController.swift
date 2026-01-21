//
//
// AuthorizationQRViewController.swift
// interesnoitochka
//
// Created by sturdytea on 21.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

class AuthorizationQRViewController: UIViewController {
    
    private let contentView = AuthorizationQRView()
    private let qrImage: UIImage
    private let telegramURL: URL

    init(qrImage: UIImage, url telegramURL: URL) {
        self.qrImage = qrImage
        self.telegramURL = telegramURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindActions()
    }

    private func configure() {
        contentView.qrImageView.image = qrImage
        contentView.showLoading(false)
    }
    
    private func bindActions() {
        contentView.telegramButton.addTarget(
            self,
            action: #selector(telegramTapped),
            for: .touchUpInside)
    }

    func showLoading(_ loading: Bool) {
        contentView.showLoading(loading)
    }
    
    @objc private func telegramTapped() {
        UIApplication.shared.open(telegramURL)
    }
}
