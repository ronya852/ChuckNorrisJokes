//
//  AppDelegate.swift
//  TestApp-VeronikaMarchuk
//
//  Created by RonchPonchPomkins on 23/1/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()
        return true
    }
}

private extension AppDelegate {
    
    func configure() {
        window = UIWindow()
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}
