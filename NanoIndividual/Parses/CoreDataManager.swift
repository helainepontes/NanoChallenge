//
//  CoreDataManager.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 04/02/21.
//  Copyright © 2021 Helaine Pontes. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    //let context = CoreDataManager.persistentContainer.viewContext
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NanoIndividual")
        container.loadPersistentStores(completionHandler: { ( _, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = CoreDataManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchFavoriteMeal() -> [MealPersistence]? {
        var meals: [MealPersistence]?
        let context = CoreDataManager.persistentContainer.viewContext
        do {
            meals = try context.fetch(MealPersistence.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        return meals
    }
    
    func saveFavoriteMeal(mealName: String) {
        let context = CoreDataManager.persistentContainer.viewContext
        let newMeal = MealPersistence(context: context)
        newMeal.name = mealName
        saveContext()
    }
    
    func removeFavoriteMeal(meal: MealPersistence) {
        let context = CoreDataManager.persistentContainer.viewContext
        context.delete(meal)
        saveContext()
    }
}
