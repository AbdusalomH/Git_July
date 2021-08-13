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
    let middleContainer = UIView()
    let bottonContainer = UIView()
    let dateLabel       = GFBodyLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        doneButtonConfigure()
        containerConfigure()
        getUsersInfo(username: username)
    }
    
    func getUsersInfo(username: String){
        NetworkManager.shared.getUser(for: username) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result{
            case .success(let user):
                guard let user = user else {return}
                DispatchQueue.main.async {
                    self.add(chilvVC: GFUserInforHeaderVC(user: user), to: self.headerContainer)
                    self.add(chilvVC: GFReportInfoVC(user:user), to: self.middleContainer)
                    self.add(chilvVC: GFFollowerItemVC(user: user), to: self.bottonContainer)
                    self.dateLabel.text = "Github since \(user.createdAt.converToDisplayFormat())"
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
    
    func doneButtonConfigure(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dimissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func containerConfigure(){
        view.addSubview(headerContainer)
        view.addSubview(middleContainer)
        view.addSubview(bottonContainer)
        view.addSubview(dateLabel)
            
        let padding: CGFloat = 12
        let containerHeight: CGFloat = 140
        
        
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        middleContainer.translatesAutoresizingMaskIntoConstraints = false
        bottonContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerContainer.heightAnchor.constraint(equalToConstant: 180),
            
            middleContainer.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: padding),
            middleContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            middleContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            middleContainer.heightAnchor.constraint(equalToConstant: containerHeight),
            
            bottonContainer.topAnchor.constraint(equalTo: middleContainer.bottomAnchor, constant: padding),
            bottonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bottonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bottonContainer.heightAnchor.constraint(equalToConstant: containerHeight),
            
            dateLabel.topAnchor.constraint(equalTo: bottonContainer.bottomAnchor, constant: padding),
            dateLabel.centerXAnchor.constraint(equalTo: bottonContainer.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
   
    }
    
    @objc func dimissVC(){
        dismiss(animated: true)
    }
    

}

