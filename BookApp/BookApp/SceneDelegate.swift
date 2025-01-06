//
//  SceneDelegate.swift
//  BookApp
//
//  Created by mun on 12/27/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let firstViewController = UINavigationController(rootViewController: SearchViewController())
        let secondViewController = UINavigationController(rootViewController: SavedBookViewController())
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([firstViewController, secondViewController], animated: true)

        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
            items[0].image = UIImage(systemName: "magnifyingglass.circle")
            items[0].title = "검색"
            items[1].selectedImage = UIImage(systemName: "book.fill")
            items[1].image = UIImage(systemName: "book")
            items[1].title = "담은 책"
        }

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

