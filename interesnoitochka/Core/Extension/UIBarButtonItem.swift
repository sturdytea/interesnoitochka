//
//
// UIBarButtonItem.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

extension UIBarButtonItem {
    @discardableResult
    func hideLiquidGlassEffect() -> UIBarButtonItem {
        if #available(iOS 26.0, *) {
            hidesSharedBackground = true
        }
        return self
    }
}
