//
//  Database+Controller.swift
//  HclTask
//
//  Created by Anand Sakthivel on 15/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController {
    
    private init() {}
    //MARK: getContext
    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }
    
    //MARK: persistentContainer
    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "HclTask")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK:- getAllDetails
    class func getAllDetails() -> [CanadaDetails.row] {
        let all = NSFetchRequest<AboutCanada>(entityName: "AboutCanada")
        
        do {
            let fetched = try DatabaseController.getContext().fetch(all)
            let datas = fetched.map { (aboutCanada: AboutCanada) -> CanadaDetails.row in
                let data = CanadaDetails.row(title: aboutCanada.title ?? "", description: aboutCanada.descriptions ?? "", imageHref: aboutCanada.imageHref ?? "")!
                
                return data
            }
            return datas
            
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }
        
        return [CanadaDetails.row]()
    }
    
    //MARK:- Delete ALL Details From CoreData
    class func deleteAllDetails() {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AboutCanada")
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            try DatabaseController.getContext().execute(deleteALL)
            DatabaseController.saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }
    
}

