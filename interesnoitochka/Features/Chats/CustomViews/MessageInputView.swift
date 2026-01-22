//
// MessageInputView.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class MessageInputView: UIView {

    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundSecondary
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Напишите сообщение",
            attributes: [
                .foregroundColor: UIColor.textSecondary
            ]
        )
        textField.font = .textM
        textField.textColor = .textPrimary
        textField.autocorrectionType = .no
        textField.returnKeyType = .send
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    var onSend: ((String) -> Void)?

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
        addSubview(containerView)
        containerView.addSubview(textField)

        NSLayoutConstraint.activate([
            
            // Container
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            // Text field
            textField.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 16
            ),
            textField.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -16
            ),
            textField.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 8
            ),
            textField.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -8
            ),
        ])
    }
}

extension MessageInputView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return false }
        onSend?(text)
        textField.text = nil
        return true
    }
}
