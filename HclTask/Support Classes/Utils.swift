//
//  Utils.swift
//  HclTask
//
//  Created by Anand Sakthivel on 14/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation
import UIKit

//MARK: - find current device is iphone or ipad
func isIpadDevice() -> Bool {
    if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
        return true
    } else {
        return false
    }
}


//MARK: - find isIphoneXSerious or not
func isIphoneXSerious() -> Bool{
    //Portrait Pixels
    if  (UI_USER_INTERFACE_IDIOM() == .phone){
        switch UIScreen.main.nativeBounds.height{
        case 1136: //iPhone 5, iPhone 5S, iPhone 5C, iPhone SE // 4 inch
            return false
        case 1334://iPhone 6, iPhone 6S, iPhone 7, iPhone 8 //4.7 inch
            return false
        case 1920, 2208: //(physical,virtual)//iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus, iPhone 8 Plus // 5.5 inch
            return false
        case 2436://iPhone X, iPhone XS, iPhone 11 Pro //5.8 inch
            return true
        case 2688://IphoneXsMax,iPhone 11 Pro Max //  6.5 inch
            return true
        case 1792, 1624://iPhone XR, iPhone 11  // 6.1 inch
            return true
        default:
            return false
        }
    }
    return false
}

func rectForText(_ text: String, font: UIFont, maxSize: CGSize) -> CGSize {
    //This is a method to calculate the height
    let attrString = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font:font])
    let rect = attrString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    let size = CGSize(width: rect.size.width, height: rect.size.height)
    return size
}
