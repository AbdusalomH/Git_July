//
//  GFButton.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 7/20/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroungColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroungColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
 
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius      = 12
        titleLabel?.textColor   = .white
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
  
    }

}
