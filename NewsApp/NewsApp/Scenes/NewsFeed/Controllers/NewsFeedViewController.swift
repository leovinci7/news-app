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
    
    var segmentControl: UISegmentedControl!
    var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Register for trait collection changes to detect size class changes
        NotificationCenter.default.addObserver(self, selector: #selector(traitCollectionDidChange(_:)), name: NSNotification.Name("MyTraitCollectionDidChangeNotification"), object: nil)
        // Initial setup based on current size class
        updateUI(for: traitCollection)
        handleLoadFeed()
    }
    
    @objc private func MyTraitCollectionDidChange(_ notification: NSNotification) {
        if let traitCollection = notification.object as? UITraitCollection {
            updateUI(for: traitCollection)
        }
    }
    
    // Update the UI based on the given size class
    private func updateUI(for traitCollection: UITraitCollection) {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            handleCompactWidthRegularHeight()
        } else if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            handleRegularWidthRegularHeight()
        } else {
            // Default method for other size classes
            handleDefaultSizeClass()
        }
    }
    
    private func handleCompactWidthRegularHeight(){
        self.setUpSegmentControlView()
        self.setUPCollectionViewWith(Column: .oneColumn)
        self.setupRefreshControl()
    }
    
    private func handleRegularWidthRegularHeight(){
        self.setUpSegmentControlView()
        self.setUPCollectionViewWith(Column: .twoColumn)
        self.setupRefreshControl()
    }
    
    private func handleDefaultSizeClass(){
        self.setUpSegmentControlView()
        self.setUPCollectionViewWith(Column: .oneColumn)
        self.setupRefreshControl()
    }
    
    private func handleLoadFeed(){
        
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







