//
//  FavoriteViewController.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 7/20/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
