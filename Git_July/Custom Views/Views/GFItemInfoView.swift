//
//  GFItemInfoView.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/13/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit


enum ItemInfoType {
    case repos, gists, followers, following
}



class GFItemInfoView: UILabel {
    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlighment: .left, fontSize: 16)
    let countLabel      = GFTitleLabel(textAlighment: .center, fontSize: 12)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func setItemInfoType(IteminfoType: ItemInfoType, withCount count: Int) {
        
        switch  IteminfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: GFSymbols.repos)
            titleLabel.text       = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: GFSymbols.gists)
            titleLabel.text       = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: GFSymbols.followers)
            titleLabel.text       = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: GFSymbols.following)
            titleLabel.text       = "Following"
        }
        countLabel.text           = String(count)
   
    }
   
}
