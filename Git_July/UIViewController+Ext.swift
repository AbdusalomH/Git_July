//
//  UIViewController+Ext.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 7/21/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func presentGFAlertOnMainThread(title: String, message: String, actionTitle: String) {
        
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: actionTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
        
        
    }
  
}
