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
    private let viewModel = AuthViewModel(
        wsClient: AuthWebSocketClient()
    )
    
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
        print("Login tapped")
        
        AuthSessionManager.shared.startLogin(
            onSessionCreated: { [weak self] sessionId in
                guard let self else { return }
                self.viewModel.startAuth(
                    sessionId: sessionId,
                    onFormURL: { url in
                        DispatchQueue.main.async {
                            print(url)
                            UIApplication.shared.open(url)
                        }
                    },
                    onAuthorized: { _ in
                    },
                    onError: { error in
                        DispatchQueue.main.async {
                            print("❌ Login failed:", error)
                        }
                    }
                )},
            onAuthorized: {
                self.viewModel.loadProfileAndFinishAuth { profile in
                    print("✅ User successfully logged in")
                    self.openChatsScreen()
                }
            },
            onError: { error in
                DispatchQueue.main.async {
                    print("❌ Login failed:", error)
                }
            }
        )
    }
    
    private func openChatsScreen() {
        let chatsViewController = ChatsViewController()
        chatsViewController.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([chatsViewController],animated: true)
    }
    
    @objc private func registerTapped() {
        print("Register tapped")
    }
}
