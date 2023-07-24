//
//  NewsFeedViewController.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 23/7/23.
//

import UIKit


struct NewsItem {
    let title: String
    let description: String
    let publishedDate: String
    let imageURL: URL
}

class NewsFeedViewController: UIViewController, UICollectionViewDelegate {

    var collectionView: UICollectionView!
    var newsItems = DummyData.getDummyNewsFeedData()

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
       // let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
       // let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      //  section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension NewsFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsItemCell", for: indexPath) as! NewsItemCollectionViewCell
        let newsItem = newsItems[indexPath.item]
        cell.configure(with: newsItem)
        return cell
    }
}

class NewsItemCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let publishedDateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        // Set up UI components and add to cell's contentView
        // Add constraints and configure appearance as needed
        //contentView.addSubview(imageView) // Uncomment this line if you want to add an image view

        // Add the labels to the contentView
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(publishedDateLabel)
        //contentView.backgroundColor = .green

        // Configure constraints for the UI components (labels, imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false

        // Set up vertical constraints for the labels
        NSLayoutConstraint.activate([
            
            //Image View constraints
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            // Title Label constraints
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            // Description Label constraints
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            // Published Date Label constraints
            publishedDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            publishedDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            publishedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            publishedDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        // Set any additional appearance and layout configurations
        // ...
    }

    func configure(with newsItem: NewsItem) {
        // Update UI components with newsItem data
        titleLabel.text = newsItem.title
        descriptionLabel.text = newsItem.description
        publishedDateLabel.text = newsItem.publishedDate
        imageView.image = UIImage()
        // Load image from newsItem.imageURL and set it to the imageView
    }
    
}


final class DummyData {
    
   
    
   static func getDummyNewsFeedData() -> [NewsItem]{
       let newsItem1 = NewsItem(
           title: "Apple Unveils New iPhone 14",
           description: "Apple announced its latest flagship iPhone 14 with exciting new features.",
           publishedDate: "2023-07-10",
           imageURL: URL(string: "https://example.com/news/iphone14.jpg")!
       )
       let newsItem2 = NewsItem(
           title: "SpaceX Successfully Launches Crewed Mission to Mars",
           description: "SpaceX achieved a major milestone by sending astronauts to Mars.",
           publishedDate: "2023-07-09",
           imageURL: URL(string: "https://example.com/news/mars_mission.jpg")!
       )
       let newsItem3 = NewsItem(
           title: "World Cup 2023: Exciting Match Ends in a Draw",
           description: "The cricket world cup match between two strong teams ended in a thrilling draw.",
           publishedDate: "2023-07-08",
           imageURL: URL(string: "https://example.com/news/cricket_world_cup.jpg")!
       )
       let newsItem4 = NewsItem(
           title: "New Study Reveals Breakthrough in Cancer Research",
           description: "Scientists made a significant discovery that could lead to a cure for cancer.",
           publishedDate: "2023-07-07",
           imageURL: URL(string: "https://example.com/news/cancer_research.jpg")!
       )
       let newsItem5 = NewsItem(
           title: "Stock Market Reaches All-Time High",
           description: "The stock market hit record levels as companies reported strong earnings.",
           publishedDate: "2023-07-06",
           imageURL: URL(string: "https://example.com/news/stock_market.jpg")!
       )
        var newsItems:[NewsItem] = []
        
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        newsItems.append(newsItem1)
        newsItems.append(newsItem2)
        newsItems.append(newsItem3)
        newsItems.append(newsItem4)
        newsItems.append(newsItem5)
        
        return newsItems
        
    }
    
}

