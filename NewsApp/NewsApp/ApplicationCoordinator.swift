//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 13/8/23.
//

import UIKit

class ApplicationCoordinator:Coordinator{
  
 let window:UIWindow
 var childCoordinator = [Coordinator]()
    
    init(window:UIWindow){
        self.window = window
    }
    
    func start() {
        let mainCoordinator = mainCoordinator()
        mainCoordinator.start()
        self.window.rootViewController = mainCoordinator.rootViewController
        childCoordinator = [mainCoordinator]
    }
}
