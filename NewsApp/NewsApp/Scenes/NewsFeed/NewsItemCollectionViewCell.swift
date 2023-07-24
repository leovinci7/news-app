//
//  NewsItemCollectionViewCell.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 24/7/23.
//
import SDWebImage
import UIKit

public class NewsItemCollectionViewCell: UICollectionViewCell {
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
        
        // Add the labels to the contentView
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(publishedDateLabel)
        
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
    }
    
    func configure(with newsItem: NewsFeedModel) {
        // Update UI components with newsItem data
        titleLabel.text = newsItem.title
        descriptionLabel.text = newsItem.description
        publishedDateLabel.text = newsItem.publishedDate.formatted()
        
        // Load image from newsItem.imageURL and set it to the imageView
        // Show the loading indicator during image loading
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
       // imageView.sd_setImage(with: newsItem.imageURL, placeholderImage: UIImage(named: "placeholderImage"))
        // Refresh the cache for a specific URL
        if let url = URL(string: newsItem.imageURL) {
            // Remove the cached image from the memory and disk
            SDImageCache.shared.removeImage(forKey: url.absoluteString, withCompletion: {
                // Image cache removed, now reload the image from the URL
                self.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage"))
            })
        }
        
    }
}
