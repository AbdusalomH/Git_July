//
//  ViewController.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 7/20/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImage           = UIImageView()
    let usernameTextfield   = GFTextfield()
    let callToActionButton  = GFButton(backgroungColor: .systemGreen, title: "Get followers")
    
    var isUsernameEntered: Bool { return !usernameTextfield.text!.isEmpty }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureButton()
        dissmisKeyboardFunc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextfield)
        usernameTextfield.delegate = self
        NSLayoutConstraint.activate([
            
            usernameTextfield.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
            usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func dissmisKeyboardFunc() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func configureButton() {
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushActionButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushActionButton() {
        
        guard  isUsernameEntered else {
            presentGFAlertOnMainThread(title: "No username", message: "Please enter a username", actionTitle: "Ok")
            return
        }
        let followerlistVC = FollowerListVC()
        followerlistVC.username = usernameTextfield.text
        followerlistVC.title = usernameTextfield.text
       
        navigationController?.pushViewController(followerlistVC, animated: true)
        
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushActionButton()
        return true
    }
    
}
