//
//  NewsFeedLoaderRemoteAPIEndToEndTest.swift
//  NewsAppTests
//
//  Created by Medhad Ashraf Islam on 21/7/23.
//
import XCTest
import NewsApp

class RemoteNewsFeedLoaderAPIEndToEndTests: XCTestCase {

    func test_endToEndTestServerGETNewsFeedResult_isNotNil() {
        switch getFeedResult() {
        case let .success(newsFeed)?:
            XCTAssertNotNil(newsFeed, "News feed is not nil")
            XCTAssertTrue(newsFeed.count > 0, "Atleast one news")
            print(newsFeed.count)
            print(newsFeed.first?.title ?? "no title")
           
        case let .failure(error)?:
            XCTFail("Expected successful feed result, got \(error) instead")
            
        default:
            XCTFail("Expected successful feed result, got no result instead")
        }
    }
    
    // MARK: - Helpers
    
    private func getFeedResult(file: StaticString = #file, line: UInt = #line) -> NewsFeedLoader.Result? {
        let testServerURL = URL(string: "https://www.cbc.ca/aggregate_api/v1/items?lineupSlug=news")!
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader = RemoteNewsFeedLoader(url: testServerURL, client: client)
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)
        
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: NewsFeedLoader.Result?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        return receivedResult
    }
    
 
}

