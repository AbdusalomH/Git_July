//
//  User.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/9/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import Foundation


struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var pulicGists: Int
    var htmlUrl:String
    var following: Int
    var followers: Int
    var createdAt: String
 
}
