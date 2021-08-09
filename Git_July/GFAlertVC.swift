//
//  GFAlertVC.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 7/20/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containverView = UIView()
    let titleLabel = GFTitleLabel(textAlighment: .center, fontSize: 20)
    let bodyLabel = GFBodyLabel(textAlighment: .center)
    let actionButton = GFButton(backgroungColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()

    }
    
    
    func configureContainerView() {
        
        view.addSubview(containverView)
        containverView.translatesAutoresizingMaskIntoConstraints = false
        containverView.backgroundColor       = .systemBackground
        containverView.layer.cornerRadius    = 16
        containverView.layer.borderWidth     = 2
        containverView.layer.borderColor     = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
        
            containverView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containverView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containverView.widthAnchor.constraint(equalToConstant: 280),
            containverView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        
        containverView.addSubview(titleLabel)
        
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: containverView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containverView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containverView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        
        ])
    }
    
    func configureActionButton() {
        containverView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
        
            actionButton.bottomAnchor.constraint(equalTo: containverView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containverView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containverView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureBodyLabel() {
        containverView.addSubview(bodyLabel)
        bodyLabel.text          = message ?? "Unable to complete request"
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containverView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containverView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)

        ])
    }
}
