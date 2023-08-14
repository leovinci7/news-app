//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 13/8/23.
//
import Foundation
import UIKit

class NewsDetailViewModel:ObservableObject {
   
    var data:NewsFeed
    
    init(news newsDetail:NewsFeed){
        self.data = newsDetail
    }
    
}
