//
//  NewsDetailViewController.swift
//  NewsApp
//  Created by Medhad Ashraf Islam on 13/8/23.
//

import UIKit
import SDWebImage

class NewsDetailViewController:UIViewController{
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let publishedDateLabel = UILabel()
    
    var viewModel:NewsDetailViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setUpDetailViewLayout()
        self.setUpDetailViewData()
        
    }
}


extension NewsDetailViewController {
    
    private func setUpDetailViewLayout(){
        // Add two content views to the cell
        let imageViewContentView = UIView()
        let labelsContentView = UIView()
        let stackView = UIStackView(arrangedSubviews: [imageViewContentView, labelsContentView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        // Add the image view to the imageViewContentView
        imageViewContentView.addSubview(imageView)
        // Add the labels to the labelsContentView
        labelsContentView.addSubview(titleLabel)
        labelsContentView.addSubview(publishedDateLabel)
       
        //MARK: Item Styling
        stackView.spacing = 4
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize - 2)
        // Add corner radius to the imageView
        imageView.layer.cornerRadius = 10 // You can adjust the value to your desired corner radius
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
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
           // stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
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
        ])
        
    }
    
    private func setUpDetailViewData(){
        guard let newsData = self.viewModel?.data else {
            return
        }
        // Update UI components with newsItem data
        titleLabel.text = newsData.description
        publishedDateLabel.text = newsData.publishedDate
        // Load image from newsItem.imageURL and set it to the imageView
        // Show the loading indicator during image loading
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        // imageView.sd_setImage(with: newsItem.imageURL, placeholderImage: UIImage(named: "placeholderImage"))
        // Refresh the cache for a specific URL
        if let url = URL(string: newsData.imageURL) {
            // Remove the cached image from the memory and disk
            SDImageCache.shared.removeImage(forKey: url.absoluteString, withCompletion: {
                // Image cache removed, now reload the image from the URL
                self.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage"))
            })
        }
        
    }
        
}
    
    

