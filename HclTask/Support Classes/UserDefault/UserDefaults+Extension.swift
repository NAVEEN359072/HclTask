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
    
    var navigationTitle : String {
        get {
            if let title = UserDefaults.standard.value(forKey: "navigationTitle") as? String {
                return title
            }
            return "About Canada"

        } set {
            UserDefaults.standard.set(newValue, forKey: "navigationTitle")
        }
    }
    
    var timeStampOfSymptomCheckerAPI: Date {
        get {
            let timeStampOfSymptomCheckerAPI =  UserDefaults.standard.object(forKey: "timeStampOfSymptomCheckerAPI")
            if timeStampOfSymptomCheckerAPI != nil {
                return (timeStampOfSymptomCheckerAPI as! Date)
            } else {
                return Date(timeIntervalSince1970: 0)
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "timeStampOfSymptomCheckerAPI")
            UserDefaults.standard.synchronize()
        }
    }
}
