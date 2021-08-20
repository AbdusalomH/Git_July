//
//  UserInfoVC.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/12/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

protocol UserInfoDelegate: class {
    func didTapGithubProfileButton(for user: User)
    func didTapGetFollowerButton(for user: User)
}

import UIKit


class UserInfoVC: UIViewController {
    
    var username: String!
    let headerContainer = UIView()
    let middleContainer = UIView()
    let bottonContainer = UIView()
    let dateLabel       = GFBodyLabel()

    var delegate: FollowerListVCDelegate!
    
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
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Otsyuda idem" , message: error.rawValue, actionTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        
        
        let reporItemVC         = GFReportInfoVC(user: user)
        reporItemVC.delegate    = self
        
        let followerItemVC      = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        
        
        self.add(chilvVC: GFUserInforHeaderVC(user: user), to: self.headerContainer)
        self.add(chilvVC: reporItemVC, to: self.middleContainer)
        self.add(chilvVC: followerItemVC , to: self.bottonContainer)
        self.dateLabel.text = "Github since \(user.createdAt.converToDisplayFormat())"
        
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


extension UserInfoVC: UserInfoDelegate {
    func didTapGithubProfileButton(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Ivalid Url", message: "The url attached is invalid", actionTitle: "Ok")
            return}
        
        profileViaSafari(url: url)
        
    }
    
    func didTapGetFollowerButton(for user: User) {
        
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "Bad news", message: "Current user doesn't have any follower", actionTitle: "So sad!")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dimissVC()
    }

}

