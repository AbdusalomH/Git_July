//
//  NetworkManager.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/9/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import UIKit


class NetworkManager{

    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    // private init() {}

    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower]?, GFError>) -> Void) {
        
        let endpoint = baseUrl+"\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let follower = try decoder.decode([Follower].self, from: data)
                completed(.success(follower))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getUser(for username: String, completed: @escaping (Result<User?, GFError>) -> Void) {
        
        let endpoint = baseUrl+"\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}


