//
//  UserInfoVC.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/12/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!
    let headerContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        doneButtonConfigure()
        containerConfigure()
        getUsersInfo(username: username)
        
    }
    
    func doneButtonConfigure(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dimissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func containerConfigure(){
        view.addSubview(headerContainer)
        
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        
        
    }
    
    @objc func dimissVC(){
        dismiss(animated: true)
    }
    
    func getUsersInfo(username: String){
        NetworkManager.shared.getUser(for: username) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(chilvVC: GFUserInforHeaderVC(user: user!), to: self.headerContainer)
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Otsyuda idem" , message: error.rawValue, actionTitle: "Ok")
            }
        }
    }
    
    func add(chilvVC: UIViewController, to containerView: UIView) {
        addChild(chilvVC)
        containerView.addSubview(chilvVC.view)
        chilvVC.view.frame = containerView.bounds
        chilvVC.didMove(toParent: self)
    }
}

