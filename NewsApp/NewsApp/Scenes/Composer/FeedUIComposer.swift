//
//  FeedUIComposer.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 24/7/23.
//

import Foundation
public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: NewsFeedLoader) -> NewsFeedViewController {
        let viewModel = NewsFeedViewModel(feedLoader: feedLoader)
        let newsFeedController = NewsFeedViewController(viewModel: viewModel)
        
        return newsFeedController
        
    }
    
}
