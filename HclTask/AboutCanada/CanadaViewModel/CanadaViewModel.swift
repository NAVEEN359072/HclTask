//
//  CanadaViewModel.swift
//  HclTask
//
//  Created by Anand Sakthivel on 15/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CanadaViewModel {
    
    //Original Array from Core Data
    
    var canadaDetails = [CanadaDetails.row]()
    
    //New Values to Core Data
    
    var details:[CanadaDetails.row]? {
        didSet {
            // Remove all Previous Records
            DatabaseController.deleteAllDetails()
            // Add the new spots to Core Data Context
            self.addCanadaDetailsToCoreData(self.details!)
            // Save them to Core Data
            DatabaseController.saveContext()
            //canadaDetails
            self.canadaDetails = DatabaseController.getAllDetails()
            ViewController().getSuccessData()
        }
    }
    
    //MARK:- addCanadaDetailsToCoreData
    
    func addCanadaDetailsToCoreData(_ details: [CanadaDetails.row]) {
        for detail in details {
            guard let entity = NSEntityDescription.entity(forEntityName: "AboutCanada", in: DatabaseController.getContext()) else {
                fatalError("could not find entity description")
                
            }
            let canada = NSManagedObject(entity: entity, insertInto: DatabaseController.getContext())
            // Set the data to the entity
            canada.setValue(detail.title, forKey: "title")
            canada.setValue(detail.description, forKey: "descriptions")
            let url: NSURL = NSURL(string: detail.imageHref ?? "")!
            do {
                _ = try NSData(contentsOf: url as URL, options: NSData.ReadingOptions())
                canada.setValue(detail.imageHref, forKey: "imageHref")
            } catch {
                canada.setValue("", forKey: "imageHref")
                print(error)
            }
            ViewController().getSuccessData()
        }
    }
    
    // get title value from coredata
    
    func getCanadaTitle(for indexPath: IndexPath) -> String? {
        return canadaDetails[indexPath.row].title ?? ""
    }
    
    // get description value from coredata
    
    func getCanadaDescription(for indexPath: IndexPath) -> String? {
        return canadaDetails[indexPath.row].description ?? ""
    }
    
    // get image value from coredata
    
    func getCanadaImage(for indexPath: IndexPath) -> String? {
        return canadaDetails[indexPath.row].imageHref ?? ""
    }
    
    // this function call the get method in apidownload classes
    
    fileprivate func GetCanadaDetailsApi<H:Codable>(withResult: @escaping (Result<H, ApiErrors>) -> ()) {
        HTTPClient.shared.getAPIResponse(baseUrl: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") { (resultData) in
            switch resultData {
            case .success(let data):
                print("datatest",data)
                DecodeHelper.ParseData(with: data, Completion: withResult)
            case .failure(let error):
                withResult(.failure(error))
            }
        }
        
    }
    
    // get the value from decoder
    
    func callCanadaDetails()  {
         GetCanadaDetailsApi(withResult:{ (_ result: Result<CanadaDetails, ApiErrors>) in
            switch result{
            case .success(let data):
                print("data",data)
                UserDefaults.standard.navigationTitle = data.title ?? ""
                self.details = data.rows
                UserDefaults.standard.timeStampOfSymptomCheckerAPI = Date()
            case .failure(let error):
                print("error",error)
            }
    })
 }
    
}
