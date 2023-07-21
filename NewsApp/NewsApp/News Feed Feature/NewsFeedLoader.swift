//
//  NewsFeedLoader.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 15/7/23.
//

import Foundation

public protocol NewsFeedLoader {
    typealias Result = Swift.Result<[NewsFeedModel], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
