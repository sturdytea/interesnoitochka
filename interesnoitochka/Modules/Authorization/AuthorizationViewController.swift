//
//
// AuthorizationViewController.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class AuthorizationViewController: UIViewController {

    private let contentView = AuthorizationView()

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindActions()
    }

    private func bindActions() {
        contentView.loginButton.addTarget(
            self,
            action: #selector(loginTapped),
            for: .touchUpInside
        )

        contentView.registerButton.addTarget(
            self,
            action: #selector(registerTapped),
            for: .touchUpInside
        )
    }

    @objc private func loginTapped() {
        // TODO: Telegram auth
        print("Login tapped")
    }

    @objc private func registerTapped() {
        print("Register tapped")
    }
}
