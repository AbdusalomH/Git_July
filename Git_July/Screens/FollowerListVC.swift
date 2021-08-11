//
//  FollowerListVC.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 7/20/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    
    enum Section { case main }
  
    var username: String!
    var followersList:[Follower] = []
    var filteredFollowers:[Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)

    }
    
    func configureSearchController() {
        let searchController                                     = UISearchController()
        searchController.searchResultsUpdater                    = self
        searchController.searchBar.delegate                      = self
        searchController.searchBar.placeholder                   = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation    = false
        navigationItem.searchController                          = searchController
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] (result) in
            
            guard let self = self else {return}
            self.stopAnimate()
            
            switch result {
            case .success(let follower):
                
                if follower!.count < 100 { self.hasMoreFollowers = false }
                self.followersList.append(contentsOf: follower!)
                
                if self.followersList.isEmpty {
                    let message = "This user doesn't have any followers, Go to follow them"
                    DispatchQueue.main.async {
                    self.showEmptyStateView(with: message, in: self.view)}
                }
                self.updateData(followers: self.followersList)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad request", message: error.rawValue, actionTitle: "Ok")
                
            }
        }
    }
    
    func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexpath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexpath) as! FollowerCell
            
            cell.setFollower(follower: follower)
            return cell
        })
    }
    
    func updateData(followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.datasource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY          = scrollView.contentOffset.y
        let contentHeight    = scrollView.contentSize.height
        let height           = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredFollowers = followersList.filter({ (results) -> Bool in
            results.login.lowercased().contains(filter.lowercased())
        })
        self.updateData(followers: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(followers: followersList)
    }
}


