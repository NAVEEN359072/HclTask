//
//  Decoder+Helper.swift
//  HclTask
//
//  Created by Anand Sakthivel on 15/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation
//Extension function which helps in avoiding nil exception when a key is missed from the Api response
extension KeyedDecodingContainer {
    func decodeWrapper<H>(key: K, defaultValue: H) throws -> H
        where H: Decodable {
            return try decodeIfPresent(H.self, forKey: key) ?? defaultValue
    }
}


// DecodeHelper helps in returning parsed data from the API Response with the help of codable generic which is used to achieve code Re-usability

class DecodeHelper {
    
    class func ParseData<H:Codable>(with responseData:Data ,Completion: @escaping (Result<H, ApiErrors>) -> ()) {
        do{
            let decoder = JSONDecoder()
            let getValues = try decoder.decode(H.self, from: responseData)
            print("Result Dictionary----->",try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as! NSDictionary)
            Completion(.success(getValues))
        }
        catch {
            print("error: ", error)
            Completion(.failure(.dataError))
        }
    }
    
}
