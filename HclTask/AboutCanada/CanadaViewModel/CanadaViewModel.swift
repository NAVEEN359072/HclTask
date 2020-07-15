//
//  CanadaViewModel.swift
//  HclTask
//
//  Created by Anand Sakthivel on 15/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation
import CoreData
class CanadaViewModel {
    
    //Original Array from Core Data
    var canadaDetails = [AboutCanada]()
    
    //New Values to Core Data
    var details:[CanadaDetails.row]? {
        didSet {
            // Remove all Previous Records
            DatabaseController.deleteAllFriends()
            // Add the new spots to Core Data Context
           // self.addCanadaDetailsToCoreData(self.details!)
            // Save them to Core Data
            DatabaseController.saveContext()
            //canadaDetails
            self.canadaDetails = DatabaseController.getAllFriends()
           
        }
    }
    
    //MARK:- addCanadaDetailsToCoreData
    func addCanadaDetailsToCoreData(_ details: [CanadaDetails.row]) {
        for detail in details {
            let entity = NSEntityDescription.entity(forEntityName: "AboutCanada", in: DatabaseController.getContext())
            let canada = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
            // Set the data to the entity
            canada.setValue(detail.title, forKey: "titleStr")
            canada.setValue(detail.description, forKey: "descriptionStr")
            canada.setValue(detail.imageHref, forKey: "imageHrefStr")
        }
    }
    
    func getCanadaTitle(for indexPath: IndexPath) -> String {
        return canadaDetails[indexPath.row].titleStr ?? ""
    }
    
    func getCanadaDescription(for indexPath: IndexPath) -> String {
        return canadaDetails[indexPath.row].descriptionStr ?? ""
    }
    
    func getCanadaImage(for indexPath: IndexPath) -> String {
        return canadaDetails[indexPath.row].imageHrefStr ?? ""
    }
    
    
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
    
    func callCanadaDetails()  {
         GetCanadaDetailsApi(withResult:{ (_ result: Result<CanadaDetails, ApiErrors>) in
            switch result{
            case .success(let data):
                print("data",data)
                self.details = data.rows
            case .failure(let error):
                print("error",error)
            }
    })
 }
    
}
