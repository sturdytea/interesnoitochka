//
//
// UIFont.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    
import UIKit

extension UIFont {

    private static func roboto(size: CGFloat, weight: RobotoWeight) -> UIFont {
        UIFont(name: weight.fontName, size: size)
        ?? .systemFont(ofSize: size)
    }

    enum RobotoWeight {
        case regular
        case medium

        var fontName: String {
            switch self {
            case .regular:
                return "Roboto-Regular"
            case .medium:
                return "Roboto-Medium"
            }
        }
    }

    // MARK: - Headings

    static var h4: UIFont {
        roboto(size: 24, weight: .medium)
    }

    static var h5: UIFont {
        roboto(size: 20, weight: .medium)
    }

    // MARK: - Text Regular

    static var textL: UIFont {
        roboto(size: 16, weight: .regular)
    }

    static var textM: UIFont {
        roboto(size: 14, weight: .regular)
    }

    static var textS: UIFont {
        roboto(size: 12, weight: .regular)
    }

    // MARK: - Text Medium

    static var textLMedium: UIFont {
        roboto(size: 16, weight: .medium)
    }

    static var textMMedium: UIFont {
        roboto(size: 14, weight: .medium)
    }
}
