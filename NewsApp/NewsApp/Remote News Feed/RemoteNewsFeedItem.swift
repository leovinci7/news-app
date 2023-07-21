//
//  RemoteNewsItem.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 15/7/23.
//

import Foundation



struct RemoteNewsFeedItem: Codable {
    let id: Int
    let title, description: String
    let sourceID, version: String
    let publishedAt: Int
    let readablePublishedAt: String
    let updatedAt: Int
    let readableUpdatedAt: String
    let type: String?
    let active, draft: Bool
    let embedTypes: String?
    let typeAttributes: NewsTypeAttributes
    let images: Images
    let language: Language
    enum CodingKeys: String, CodingKey {
           case id, title, description, sourceID = "sourceId", version, publishedAt, readablePublishedAt, type, updatedAt, readableUpdatedAt, active, draft, embedTypes, typeAttributes, images, language
       }
}

enum NewsType: String, Codable {
    case contentpackage
    case story
}

// MARK: - NewsTypeAttributes
struct NewsTypeAttributes: Codable {
    let uppercaseHeadline: Bool?
    let components: Components?
    let url: String
    let urlSlug, deck: String
    let imageSmall, imageLarge: String
    let imageAspects: String
    let displayComments: Bool
    let show, showSlug: String
    let sectionList, sectionLabels: [String]
}

// MARK: - Components
struct Components: Codable {
    let mainContent: MainContent
}

// MARK: - MainContent
struct MainContent: Codable {
    let id: Int
    let title, description: String
    let publishedAt: Int
    let readablePublishedAt: String
    let updatedAt: Int
    let readableUpdatedAt: String
    let type: String
    let active, draft: Bool
    let embedTypes: String
    let images: Images
    let language: Language
}


// MARK: - Images
struct Images: Codable {
    let square140: String
    enum CodingKeys: String, CodingKey {
        case square140 = "square_140"
    }
}

enum Language: String, Codable {
    case en
}
