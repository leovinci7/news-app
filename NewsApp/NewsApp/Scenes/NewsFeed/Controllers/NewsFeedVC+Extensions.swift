//
//  NewsFeedViewController+Extensions.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 3/8/23.
//

import UIKit

//MARK: - Filter logic for UI
extension NewsFeedViewController {
    
    func setUpSegmentControlView(){
        segmentControl = UISegmentedControl(items: viewModel!.data.types)
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentIndex = selectedSegmentIndex // Set the default selected segment index
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
    
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        filterNewsFeed()
        collectionView.reloadData()
    }
    
    private func filterNewsFeed() {
        guard selectedSegmentIndex >= 0 && selectedSegmentIndex < segmentControl.numberOfSegments else {
            return
        }
        let selectedType = segmentControl.titleForSegment(at: selectedSegmentIndex) ?? ""
        self.viewModel?.filterBy(Type: selectedType)
        collectionView.reloadData()
    }
    
}
//MARK: - CollectionView SetUP
extension NewsFeedViewController {
    
    enum LayoutStyle {
        case oneColumn
        case twoColumn
        case threeColumn
    }
    func setUPCollectionViewWith(Column columnSize: LayoutStyle = .oneColumn){
        
        switch columnSize {
        case .oneColumn:
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createOneColumnLayout())
        case .twoColumn:
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnLayout())
        default:
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createOneColumnLayout())
            }
        
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
    
    private func createOneColumnLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(0), top: .fixed(8), trailing: .fixed(0), bottom: .fixed(8))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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
        selectedSegmentIndex = -1
        viewModel?.loadFeed() ?? {
            print("viewModel is not initialized")
        }()
    }
}

