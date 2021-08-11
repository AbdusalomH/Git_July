//
//  GFEmtyState.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/11/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class GFEmtyState: UIView {
    
    let messageLable = GFTitleLabel(textAlighment: .center, fontSize: 28)
    let logoImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String){
        super.init(frame: .zero)
        messageLable.text = message
        configure()
    }
    
    private func configure(){
        addSubview(messageLable)
        addSubview(logoImage)
        
        messageLable.numberOfLines = 3
        messageLable.textColor = .secondaryLabel
        
        logoImage.image = UIImage(named: "empty-state-logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLable.heightAnchor.constraint(equalToConstant: 200),
            
            logoImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
    
}
