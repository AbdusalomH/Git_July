//
//  GFFollowerItemVC.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/13/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    
    func configure(){
        itemInfoViewOne.setItemInfoType(IteminfoType: .followers, withCount: user.followers)
        ItemInfoViewTwo.setItemInfoType(IteminfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get followers")
    }
    
    override func didtapButton() {
        delegate?.didTapGetFollowerButton(for: user)
    }

}
