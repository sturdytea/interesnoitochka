//
//
// ActionButton.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

final class ActionButton: UIControl {
    
    // MARK: - Style
    
    enum Style {
        case primary
        case secondary
        
        var backgroundColor: UIColor {
            switch self {
            case .primary:
                return .backgroundAction
            case .secondary:
                return .backgroundActionSecondary
            }
        }
        
        var titleColor: UIColor {
            .textPrimary
        }
    }
    
    // MARK: - UI
    
    private let titleLabel = UILabel()
    private let style: Style
    
    // MARK: - Init
    
    init(title: String, style: Style) {
        self.style = style
        super.init(frame: .zero)
        setupUI()
        setTitle(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public API
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    override var isEnabled: Bool {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        titleLabel.font = .textL
        titleLabel.textColor = style.titleColor
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 42),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func updateState() {
        alpha = isEnabled ? 1.0 : 0.5
        isUserInteractionEnabled = isEnabled
    }
    
    // MARK: - Touch feedback
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate(scale: 0.97)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate(scale: 1.0)
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate(scale: 1.0)
        super.touchesCancelled(touches, with: event)
    }
    
    private func animate(scale: CGFloat) {
        UIView.animate(withDuration: 0.15) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
}
