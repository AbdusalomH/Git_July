//
//  UIViewController+Ext.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 7/21/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    
    func presentGFAlertOnMainThread(title: String, message: String, actionTitle: String) {
        
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: actionTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func showLoadingView(){
        
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha     = 0
        
        UIView.animate(withDuration: 0.25){ containerView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func stopAnimate(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        
        let emptyStateView = GFEmtyState(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
        
    }
}
