//
//  PersistanceManager.swift
//  Git_July
//
//  Created by Abdusalom Hojiev on 8/26/21.
//  Copyright © 2021 Abdusalom Hojiev. All rights reserved.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}


enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updatewWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                
                var retrievFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievFavorites.append(favorite)
  
                case .remove:
                    retrievFavorites.removeAll { $0.login == favorite.login}
                }
                
                completed(save(favorites: retrievFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
 
    }
    
 
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoriteData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorited = try decoder.decode([Follower].self, from: favoriteData)
            completed(.success(favorited))
            
        } catch {
            completed(.failure(.unableToFavortie))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encoderFavorites = try encoder.encode(favorites)
            defaults.set(encoderFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavortie
        }
    }
}
