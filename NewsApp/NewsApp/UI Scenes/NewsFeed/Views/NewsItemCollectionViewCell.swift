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
        
        // Add two content views to the cell
        let imageViewContentView = UIView()
        let labelsContentView = UIView()
        let stackView = UIStackView(arrangedSubviews: [imageViewContentView, labelsContentView])
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        // Add the image view to the imageViewContentView
        imageViewContentView.addSubview(imageView)
        // Add the labels to the labelsContentView
        labelsContentView.addSubview(titleLabel)
        labelsContentView.addSubview(publishedDateLabel)
       
        
        
        //MARK: Item Styling
        // imageViewContentView.backgroundColor = .green
        // labelsContentView.backgroundColor = .red
        stackView.spacing = 4
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize - 2)
        // Add corner radius to the imageView
        imageView.layer.cornerRadius = 10 // You can adjust the value to your desired corner radius
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true // Make sure to enable clipping so the corners are visible
        publishedDateLabel.font = UIFont.systemFont(ofSize: 12)
        publishedDateLabel.textColor = UIColor.darkGray
        
        //MARK: Configure constraints for the UI components (labels, imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //Stack View Constraint
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            labelsContentView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1.0/5.0),
            
            //Image View constraints
            imageView.topAnchor.constraint(equalTo: imageViewContentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: imageViewContentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: imageViewContentView.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: imageViewContentView.bottomAnchor, constant: -8),
            
            
            // Title Label constraints
            titleLabel.topAnchor.constraint(equalTo: labelsContentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: labelsContentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: labelsContentView.trailingAnchor, constant: -8),
            
            // Published Date Label constraints
            publishedDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            publishedDateLabel.leadingAnchor.constraint(equalTo: labelsContentView.leadingAnchor, constant: 8),
            publishedDateLabel.trailingAnchor.constraint(equalTo: labelsContentView.trailingAnchor, constant: -8),
            // publishedDateLabel.bottomAnchor.constraint(equalTo: labelsContentView.bottomAnchor, constant: -8),
        ])
        
    }
    
    func configure(with newsItem: NewsFeed) {
        // Update UI components with newsItem data
        titleLabel.text = newsItem.title
        publishedDateLabel.text = newsItem.publishedDate
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
