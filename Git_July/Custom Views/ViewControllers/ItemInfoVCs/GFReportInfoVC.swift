//
//  GFReportInfoVC.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/13/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class GFReportInfoVC: GFItemInfoVC{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    
    func configure(){
        itemInfoViewOne.setItemInfoType(IteminfoType: .repos, withCount: user.publicRepos)
        ItemInfoViewTwo.setItemInfoType(IteminfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Go to Profile")
   
    }
    
    override func didtapButton() {
        delegate!.didTapGithubProfileButton(for: user)
    }

}
