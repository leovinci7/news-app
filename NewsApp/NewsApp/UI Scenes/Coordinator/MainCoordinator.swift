//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 10/8/23.
//

import UIKit
import SwiftUI

class mainCoordinator:NSObject, Coordinator{
    
    let rootViewController:UINavigationController
    
    override init(){
        rootViewController = UINavigationController()
        super.init()
        rootViewController.delegate = self
       // rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    lazy var newsVC:NewsFeedViewController = {
        let url = APIConstants.newsURL
        let client = URLSessionHTTPClient()
        let loader = RemoteNewsFeedLoader(url: url, client: client)
        let newsVM = NewsFeedViewModel(feedLoader: loader)
        let newsVC = NewsFeedViewController()
        newsVC.title = "News"
        newsVC.viewModel = newsVM
        newsVC.showNewsDetail = { [weak self] data in
                self?.showNewsDetail(news: data)
        }
        return newsVC
    }()
   
    func start() {
        rootViewController.setViewControllers([newsVC], animated: false)
    }
    
    func showNewsDetail(news newsDetail:NewsFeed){
        let detailVC = NewsDetailViewController()
        let detailVM = NewsDetailViewModel(news: newsDetail)
        detailVC.viewModel = detailVM
        rootViewController.pushViewController(detailVC, animated: true)
    }
    
    
    deinit {
        print("mainCoordinator deallocated")
    }
    
}

extension mainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
//        if viewController as? UIHostingController<FirstDetailView> != nil {
//            print("detail will be shown")
//        } else if viewController as? FirstViewController != nil {
//            print("first will be shown")
//        }
    }
}
