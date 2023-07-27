//
//  NewsFeedViewModel.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 24/7/23.
//

import Foundation

final class NewsFeedViewModel {
    
    typealias Observer<T> = (T) -> Void
    
    private let feedLoader: NewsFeedLoader
   // var newsFeed:[NewsFeedModel]
    
    init(feedLoader: NewsFeedLoader) {
        self.feedLoader = feedLoader
       // self.newsFeed = []
    }
    
    var onFeedLoad: Observer<[NewsFeedModel]>?
    var onFeedLoadError: Observer<Error>?
    
    func loadFeed(){
        feedLoader.load(completion: { [weak self] result in
            if let feed = try? result.get(){
                self?.onFeedLoad?(feed)
            } 
        })
    }
    
    
}
