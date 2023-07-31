//
//  NewsFeedViewModel.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 24/7/23.
//

import Foundation

struct NewsFeedViewData {
    public let title: String
    public let description: String
    public let imageURL: String
    public let publishedDate: String
    public let type: String?
}

final class NewsFeedViewModel {
    
    typealias Observer<T> = (T) -> Void
    
    private let feedLoader: NewsFeedLoader
    
    init(feedLoader: NewsFeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var onFeedLoad: Observer<[NewsFeedViewData]>?
    var onFeedLoadError: Observer<Error>?
    
    func loadFeed(){
        feedLoader.load(completion: { [weak self] result in
            if let feed = try? result.get(){
                self?.onFeedLoad?(feed.toModels())
            }
        })
    }
    
    
}



private extension Array where Element == NewsFeedModel {
    func toModels() -> [NewsFeedViewData] {
        return map { NewsFeedViewData(title: $0.title,
                                      description: $0.description,
                                      imageURL: $0.imageURL,
                                      publishedDate: self.getFormattedDateFrom(Integer: $0.publishedDate),
                                      type: $0.type) }
    }
    
    func getFormattedDateFrom(Integer intDate:Int) -> String {
        //converting from milliseconds to seconds and then date
        let date =  Date(timeIntervalSince1970: Double(intDate) / 1000.0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy" // Format the date string as "Jul 12, 2023"
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
}


