//
//  TabBarController.swift
//  TestApp-VeronikaMarchuk
//
//  Created by RonchPonchPomkins on 23/1/2021.
//

import UIKit

class TabBarController: UITabBarController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Configure

private extension TabBarController {

    func configure() {
        configureViewControllers()
        configureTabBar()
    }

    func configureViewControllers() {

        // - 1
        let jokesVC = UIStoryboard(name: "Jokes", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let jokesTabBarItem = UITabBarItem()
        jokesTabBarItem.image = UIImage(named: "Jokes")
        jokesTabBarItem.title = "JOKES"
        jokesTabBarItem.selectedImage = UIImage(named: "JokesSelected")
        jokesVC.tabBarItem = jokesTabBarItem

        // - 2
        let APIVC = UIStoryboard(name: "WebView", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let APITabBarItem = UITabBarItem()
        APITabBarItem.image = UIImage(named: "API")
        APITabBarItem.selectedImage = UIImage(named: "APISelected")
        APIVC.tabBarItem = APITabBarItem

        viewControllers = [jokesVC, APIVC]
        
    }

    func configureTabBar() {
        tabBar.tintColor = .black
    }
}
