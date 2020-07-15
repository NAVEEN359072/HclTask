//
//  UserDefaults+Extension.swift
//  HclTask
//
//  Created by Anand Sakthivel on 15/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    //MARK:- Network selection screen
    var isNetworkAvailable : Bool
    {
        get {
            if let networkAvailable = UserDefaults.standard.value(forKey: "NetworkAvailable") as? Bool {
                return networkAvailable
            }
            return false
        } set {
            
            UserDefaults.standard.set(newValue, forKey: "NetworkAvailable")
        }
    }
}
