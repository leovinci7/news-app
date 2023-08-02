//
//  AlertViewController.swift
//  NewsApp
//
//  Created by Medhad Ashraf Islam on 31/7/23.
//

import UIKit

class AlertViewController {
    
    static func showAlert(in viewController: UIViewController, title: String?, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}

