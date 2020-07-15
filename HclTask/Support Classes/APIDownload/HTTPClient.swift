//
//  HTTPClient.swift
//  HclTask
//
//  Created by Anand Sakthivel on 15/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation

public enum ApiErrors: String,Error,CustomStringConvertible {
    case networkError
    case dataError
    case encodingError
    case unknownError
    
    public var description: String {
        return "\(self.rawValue)"
    }
}

typealias resultData = (Result<Data, ApiErrors>) -> ()

//Creating a Singleton class for ApiServices within the application
class HTTPClient: NSObject {
    //MARK: INIT
    static let shared: HTTPClient = {
        let instance = HTTPClient()
        return instance
    }()
    private override init() {}
    
    //MARK: Properties
    //This enum is used to choose the API type in Webservices
    private enum APIMethod: String{
        case get
    }
    
    //MARK: Operations
    public func getAPIResponse(baseUrl: String,completion: @escaping resultData) -> () {
        DispatchQueue.global(qos: .userInitiated).async {
            // Encoding the URL applied
            if let encodedUrl = baseUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                guard let url = URL(string: encodedUrl) else { return }
                // Creating URL Request
                var urlRequest = URLRequest.init(url:url, cachePolicy:NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
                urlRequest.setValue("application/json", forHTTPHeaderField:"Accept")
                urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
                urlRequest.httpMethod = APIMethod.get.rawValue.uppercased()
                
                // Configuring the session
                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = TimeInterval(30)
                configuration.timeoutIntervalForResource = TimeInterval(30)
                let session = URLSession(configuration: configuration)
                
                //Starting downloadTask
                let downloadTask = session.dataTask(with: urlRequest) {
                    (data, response, error) in
                    DispatchQueue.main.async {
                        //If download results in error
                        guard error == nil else {
                            completion(.failure(.networkError))
                            return
                        }
                        // If downloaded data is found to be error
                        guard let responseData = data else {
                            completion(.failure(.dataError))
                            return
                        }
                        
                        let str = String(decoding:responseData, as: UTF8.self)
                        let jsonData = str.data(using: .utf8)!
                        //Successful data
                        DispatchQueue.main.async(execute: {
                            completion(.success(jsonData))
                        })
                    }
                }
                downloadTask.resume()
            } else {
                // Encoding Failed
                completion(.failure(.encodingError))
            }
        }
    }
    
}
