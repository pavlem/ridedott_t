//
//  UserDefaultsHelper.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 26.4.21..
//

import Foundation

class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    
    enum Keys: String, CaseIterable {
        case colorsFilter
        
        var string: String {
            return self.rawValue
        }
    }
    
    // MARK: - Properties
    var colorsFilter: [String]? {
        get {
            return UserDefaults.standard.array(forKey: Keys.colorsFilter.string) as? [String]
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.colorsFilter.string)
            UserDefaults.standard.synchronize()
        }
    }

}
