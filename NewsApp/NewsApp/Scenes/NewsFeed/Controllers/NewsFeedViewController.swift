//
//  NewsFeedViewController.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 23/7/23.
//

import UIKit
import SDWebImage

public class NewsFeedViewController: UIViewController{
    
    var viewModel: NewsFeedViewModel? = nil
    private var newsFeed:[NewsFeedModel] = []
    
    var collectionView: UICollectionView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUPCollectionView()
        
        self.viewModel?.onFeedLoad = {[weak self] feed in
            DispatchQueue.main.async {
                self?.newsFeed = feed
                self?.collectionView.reloadData()
                }
        }
        
      
        self.viewModel?.loadFeed() ?? {
            //show or print error
            print("Viewmodel not initialized")
        }()
        
       // performDelayedTask()
    }
    
}

extension NewsFeedViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsFeed.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsItemCell", for: indexPath) as! NewsItemCollectionViewCell
        let newsItem = self.newsFeed[indexPath.item]
        cell.configure(with: newsItem)
        return cell
    }
}

extension NewsFeedViewController {
    
    private func setUPCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsItemCollectionViewCell.self, forCellWithReuseIdentifier: "NewsItemCell")
        view.addSubview(collectionView)
        
        // Set up constraints for the collection view to fill the view controller's view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func createTwoColumnLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(0), top: .fixed(8), trailing: .fixed(0), bottom: .fixed(8))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
         let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
         let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
          section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func performDelayedTask() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
        // This code block will be executed after a 10-second delay
            print("Delayed task completed!")
            self.collectionView.reloadData()
        }
    }
    
}





