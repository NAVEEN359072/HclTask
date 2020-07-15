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
        let container = NSPersistentContainer(name: "AboutCanada")
        
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
    
    //MARK:- getAllFriends
    class func getAllFriends() -> Array<AboutCanada> {
        let all = NSFetchRequest<AboutCanada>(entityName: "AboutCanada")
        var allFriends = [AboutCanada]()
        
        do {
            let fetched = try DatabaseController.getContext().fetch(all)
            allFriends = fetched
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }
        
        return allFriends
    }
    
    //MARK:- Delete ALL Friends From CoreData
    class func deleteAllFriends() {
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

