//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 12/7/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // var window: UIWindow?
    var appCoordinator:ApplicationCoordinator?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        appCoordinator = ApplicationCoordinator(window: window)
        appCoordinator?.start()
        window.makeKeyAndVisible()
    }
    
}

