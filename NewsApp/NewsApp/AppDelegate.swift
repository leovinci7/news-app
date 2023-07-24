//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 12/7/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize the window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create the feed loader (You need to implement the NewsFeedLoader protocol)
        let httpClient = URLSessionHTTPClient()
        let newsURL = APIConstants.newsURL
        let newsFeedLoader = RemoteNewsFeedLoader(url:newsURL , client: httpClient)
        
        // Create the NewsFeedViewController using FeedUIComposer
        let newsFeedController = FeedUIComposer.feedComposedWith(feedLoader: newsFeedLoader)
        
        // Set the NewsFeedViewController as the root view controller
        window?.rootViewController = newsFeedController
        
        // Make the window visible
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

