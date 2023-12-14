//
//  UserDefaultsManager.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 11/18/23.
//

import Foundation

final class UserDefaultsManager {
    
    let storage: UserDefaults = UserDefaults.standard
    
    func add(integer: Int, key: UserDefaultKeys) {
        storage.setValue(integer, forKey: key.rawValue)
    }
    
    func getIntWith(key: UserDefaultKeys) -> Int? {
        let new = storage.value(forKey: key.rawValue) as? Int
        return new
    }
    
}
