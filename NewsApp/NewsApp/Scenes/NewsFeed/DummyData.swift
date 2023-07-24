//
//  DummyData.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 24/7/23.
//

import Foundation


struct NewsItem {
    let title:String
    let description:String
    let publishedDate:String
    let imageURL:URL 
    
}
final class DummyData {
    
    static func getDummyNewsFeedData() -> [NewsItem]{
        let newsItem1 = NewsItem(
            title: "Apple Unveils New iPhone 14",
            description: "Apple announced its latest flagship iPhone 14 with exciting new features.",
            publishedDate: "2023-07-10",
            imageURL: URL(string: "https://picsum.photos/200")!
        )
        let newsItem2 = NewsItem(
            title: "SpaceX Successfully Launches Crewed Mission to Mars",
            description: "SpaceX achieved a major milestone by sending astronauts to Mars.",
            publishedDate: "2023-07-09",
            imageURL: URL(string: "https://picsum.photos/200")!
        )
        let newsItem3 = NewsItem(
            title: "World Cup 2023: Exciting Match Ends in a Draw",
            description: "The cricket world cup match between two strong teams ended in a thrilling draw.",
            publishedDate: "2023-07-08",
            imageURL: URL(string: "https://picsum.photos/200")!
        )
        let newsItem4 = NewsItem(
            title: "New Study Reveals Breakthrough in Cancer Research",
            description: "Scientists made a significant discovery that could lead to a cure for cancer.",
            publishedDate: "2023-07-07",
            imageURL: URL(string: "https://picsum.photos/200")!
        )
        let newsItem5 = NewsItem(
            title: "Stock Market Reaches All-Time High",
            description: "The stock market hit record levels as companies reported strong earnings.",
            publishedDate: "2023-07-06",
            imageURL: URL(string: "https://picsum.photos/200")!
        )
        var newsItems:[NewsItem] = []
        
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
