//
//  NewsFeedViewController.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 23/7/23.
//

import UIKit

public class NewsFeedViewController: UIViewController{
    
    var viewModel: NewsFeedViewModel? = nil
    var selectedSegmentIndex = -1
    //private var filteredNewsFeed:[NewsFeed] = []
   // private var newsFeed:[NewsFeed] = []
   // private var types:[String] = []
    
    var segmentControl: UISegmentedControl!
    var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setUpSegmentControlView()
        self.setUPCollectionView()
        self.setupRefreshControl()
        
        
        self.viewModel?.onFeedLoad = {[weak self]  in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self?.refreshControl.endRefreshing()
                self?.setUpSegmentControlView()
                self?.collectionView.reloadData()
                print("reloading collectionview")
            }
        }
        self.viewModel?.onFeedLoadError = {[weak self] errorMsg in
            DispatchQueue.main.async{
                if let currentViewController = self {
                    AlertViewController.showAlert(in: currentViewController, title: "Error", message: errorMsg){
                        self?.refreshControl.endRefreshing()
                    }
                }
                
            }
        }
        
        self.viewModel?.loadFeed() ?? {
            //show or print error
            print("Viewmodel not initialized")
        }()
        
    }
    
}


//MARK: - CollectionView Delegate and Data Source
extension NewsFeedViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel!.data.feed.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsItemCell", for: indexPath) as! NewsItemCollectionViewCell
        let newsItem = self.viewModel!.data.feed[indexPath.item]
        cell.configure(with: newsItem)
        return cell
    }
}







