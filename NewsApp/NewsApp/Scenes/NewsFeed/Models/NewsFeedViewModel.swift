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
    var onFeedLoadError: Observer<String>?
    
    func loadFeed(){
        feedLoader.load(completion: { [weak self] result in
            do {
                let feed = try result.get()
                self?.onFeedLoad?(feed.toViewData())
            }catch {
                var errorMsg = ""
                switch error as? RemoteNewsFeedLoader.Error {
                case .connectivity:
                    errorMsg = "Connection Error"
                case .invalidData:
                    errorMsg = "Invalid Data"
                case .invalidStatusCode:
                    errorMsg = "Request Error"
                default:
                    errorMsg = "Unknown Error"
                }
                
                self?.onFeedLoadError?(errorMsg)
            }
        })
    }
    
    
}



private extension Array where Element == NewsFeedModel {
    func toViewData() -> [NewsFeedViewData] {
        let sortedModels = self.sorted(by: {$0.publishedDate > $1.publishedDate})
        return sortedModels.map { NewsFeedViewData(title: $0.title,
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


