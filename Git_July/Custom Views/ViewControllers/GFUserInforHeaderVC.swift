//
//  GFUserInforHeaderVC.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/12/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class GFUserInforHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usenameLabel = GFTitleLabel(textAlighment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 20)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 20)
    let bioLable = GFBodyLabel(textAlighment: .center)
    
    
    var user: User!
    
    init(user:User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        layoutUI()
        configureUIElement()

        
    }
    
    func configureUIElement(){
        avatarImageView.dowloadImage(from: user.avatarUrl)
        usenameLabel.text = user.login
        nameLabel.text = user.name ?? "Not available"
        locationImageView.image = UIImage(systemName: Constants.location)
        locationLabel.text = user.location ?? "Not available"
        bioLable.text = user.bio ?? "No data"
        
    }

    func addSubViews(){
        view.addSubview(avatarImageView)
        view.addSubview(usenameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLable)
    }
    
    func layoutUI(){
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        bioLable.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usenameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usenameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usenameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usenameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLable.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLable.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
