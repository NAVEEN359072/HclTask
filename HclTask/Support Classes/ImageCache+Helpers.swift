//
//  ImageCache+Helpers.swift
//  HclTask
//
//  Created by Anand Sakthivel on 15/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
var imageUrlString: String?
extension UIImageView {
    
    func loadImageviewUsingUrlString(urlString: String) {
      
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
       
            URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
                
                if error != nil {
                    print(error ?? "")
                    return
                }
                
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data!) else { return }
                    
                    if imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                }
                
            }).resume()
        
    }
}
