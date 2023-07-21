//
//  NewsFeedModel.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 15/7/23.
//

import Foundation

public struct NewsFeedModel: Equatable {
    public let id: Int
    public let title: String?
    public let description: String?
    public let imageURL: String?
    public let publishedDate: Int
    public let type: String?
    
    public init(id: Int, title: String?, description: String?, imageURL: String?, publishedDate: Int, type: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.publishedDate = publishedDate
        self.type = type 
    }
}
