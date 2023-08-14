//
//  DummyData.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 24/7/23.
//

import Foundation



final class DummyData {
    
    static func getDummyNewsFeedData() -> [NewsFeedModel]{
       
        let newsItem1 = NewsFeedModel(
            id: 1,
            title: "Breaking News 1",
            description: "This is the first breaking news description.",
            imageURL: "https://picsum.photos/200",
            publishedDate: 1678991823,
            type: "breaking"
        )

        let newsItem2 = NewsFeedModel(
            id: 2,
            title: "News Update 1",
            description: "This is the first news update description.",
            imageURL: "https://picsum.photos/200",
            publishedDate: 1678983123,
            type: "update"
        )

        let newsItem3 = NewsFeedModel(
            id: 3,
            title: "Sports News 1",
            description: "This is the first sports news description.",
            imageURL: "https://picsum.photos/200",
            publishedDate: 1678974923,
            type: "sports"
        )

        let newsItem4 = NewsFeedModel(
            id: 4,
            title: "Entertainment News 1",
            description: "This is the first entertainment news description.",
            imageURL: "https://picsum.photos/200",
            publishedDate: 1678966423,
            type: "entertainment"
        )

        let newsItem5 = NewsFeedModel(
            id: 5,
            title: "Technology News 1",
            description: "This is the first technology news description.",
            imageURL: "https://picsum.photos/200",
            publishedDate: 1678957923,
            type: "technology"
        )

        var newsItems:[NewsFeedModel] = []
        
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        
        return newsItems
        
    }
    
}
