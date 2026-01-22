//
//
// AppDelegate.swift
// interesnoitochka
//
// Created by sturdytea on 20.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    let barButtonAppearance = UIBarButtonItem.appearance()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        Task {
            do {
                let sessionId = try await AnonymousSessionManager.shared.ensureSessionId()
                print("✅ Anonymous session id:", sessionId)
            } catch {
                print("❌ Failed to create anonymous session:", error)
            }
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: AuthorizationViewController())
        window.rootViewController = navigationController
        
        
        // Make back button custom
//        let backButton = UIImage(named: "ChevronLeftIcon")
        
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}















            
