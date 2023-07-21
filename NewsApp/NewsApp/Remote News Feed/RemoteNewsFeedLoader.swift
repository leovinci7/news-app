//
//  RemoteNewsFeedLoader.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 15/7/23.
//

import Foundation

public final class RemoteNewsFeedLoader: NewsFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = NewsFeedLoader.Result
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(RemoteNewsFeedLoader.map(data, from: response))
                
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try RemoteNewsFeedItemsMapper.map(data, from: response)
            return .success(items.toModels())
        } catch {
            return .failure(error)
        }
    }
}

private extension Array where Element == RemoteNewsFeedItem {
    func toModels() -> [NewsFeedModel] {
        return map { NewsFeedModel(id: $0.id, title: $0.title, description: $0.description, imageURL: $0.typeAttributes.imageLarge, publishedDate: $0.publishedAt, type: $0.type) }
    }
}


final class RemoteNewsFeedItemsMapper {
    private struct Root: Decodable {
        let items: [RemoteNewsFeedItem]
    }
    
    private static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteNewsFeedItem] {
        guard response.statusCode == OK_200,
            let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteNewsFeedLoader.Error.invalidData
        }
        return root.items
    }
}

