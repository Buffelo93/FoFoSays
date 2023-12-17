//
//  UserDefaultsManager.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/18/23.
//

import Foundation

final class UserDefaultsManager {
    
    let storage: UserDefaults = UserDefaults.standard
    
    func set(integer: Int, key: UserDefaultKeys) {
        storage.set(integer, forKey: key.rawValue)
    }
    
    func getIntWith(key: UserDefaultKeys) -> Int {
        storage.integer(forKey: key.rawValue)
    }
    
    func set(bool: Bool, key: UserDefaultKeys) {
        storage.set(bool, forKey: key.rawValue)
    }
    
    func getBoolWith(key: UserDefaultKeys) -> Bool {
        storage.bool(forKey: key.rawValue)
    }
    
}
