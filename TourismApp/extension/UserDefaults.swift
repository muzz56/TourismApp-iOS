//
//  UserDefaults.swift
//  TourismApp
//
//  Created by Wanja on 2021-04-06.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case rememberMe
    }

    func setRememberMe(value: Bool) {
        set(value, forKey: UserDefaultsKeys.rememberMe.rawValue)
    }

    func isRememberMe() -> Bool {
        return bool(forKey: UserDefaultsKeys.rememberMe.rawValue)
    }


}
