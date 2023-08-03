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
    var selectedSegmentIndex = 0
    private var filteredNewsFeed:[NewsFeed] = []
    private var newsFeed:[NewsFeed] = []
    private var types:[String] = []
    
    var segmentControl: UISegmentedControl!
    var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setUpSegmentControlView()
        self.setUPCollectionView()
        self.setupRefreshControl()

        
        self.viewModel?.onFeedLoad = {[weak self] newsViewData in
            self?.newsFeed = newsViewData.feed
            self?.types = newsViewData.types
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
        return self.filteredNewsFeed.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsItemCell", for: indexPath) as! NewsItemCollectionViewCell
        let newsItem = self.filteredNewsFeed[indexPath.item]
        cell.configure(with: newsItem)
        return cell
    }
}


//MARK: - SegmentView Configuration
extension NewsFeedViewController {
    
    private func setUpSegmentControlView(){
            segmentControl = UISegmentedControl(items: types)
            segmentControl.backgroundColor = .white
            segmentControl.selectedSegmentIndex = 0 // Set the default selected segment index
            segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged) // Add a target for the value changed event
                view.addSubview(segmentControl)
           // segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged) // Add a target for the value changed event
            view.addSubview(segmentControl)
            
           // Set up constraints for the segmented control
            segmentControl.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                segmentControl.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    
    private func updateSegmentControl() {
            segmentControl.removeAllSegments()
        for (index,type) in self.types.enumerated() {
                segmentControl.insertSegment(withTitle: type, at: index, animated: false)
            }
        }
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        filterNewsFeed()
        collectionView.reloadData()
    }
    
    private func filterNewsFeed() {
        guard selectedSegmentIndex >= 0 && selectedSegmentIndex < segmentControl.numberOfSegments else {
            filteredNewsFeed = newsFeed
            return
        }
        
        let selectedType = segmentControl.titleForSegment(at: selectedSegmentIndex) ?? ""
        filteredNewsFeed = newsFeed.filter { $0.type == selectedType }
    }
    
}
//MARK: - CollectionView SetUP
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
            collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
}
    
    private func createTwoColumnLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalWidth(0.50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(0), top: .fixed(8), trailing: .fixed(0), bottom: .fixed(8))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}


//MARK: extension for refresh control
extension NewsFeedViewController {
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refreshData(){
        self.viewModel?.loadFeed() ?? {
            print("viewModel is not initialized")
        }()
    }
}





