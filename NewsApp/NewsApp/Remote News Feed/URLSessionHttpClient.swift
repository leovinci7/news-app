//
//  URLSessionHttpClient.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 15/7/23.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
         self.session = session
//        // Create a custom URLCache with zero memory capacity and set it as the URLCache for the URLSession configuration
//        let configuration = URLSessionConfiguration.default
//        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
//        self.session = URLSession(configuration: configuration)
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
