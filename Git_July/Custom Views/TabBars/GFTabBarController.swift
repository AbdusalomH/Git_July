//
//  GFTabBarController.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 9/22/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor         = .systemGreen
        UINavigationBar.appearance().tintColor  = .systemGreen
        viewControllers                         = [searchC(), favortiveC()]


    }
    
    func searchC() -> UINavigationController {
    
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func favortiveC() -> UINavigationController {
        
        let favoritesVC = FavoritesVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }


}
