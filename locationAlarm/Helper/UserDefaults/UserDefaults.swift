//
//  UserDefaults.swift
//  locationAlarm
//
//  Created by Kaique Futemma on 24/12/18.
//  Copyright © 2018 Kaique Futemma. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys:String {
        case isLoggedIn
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
