//
//  MealPersistence+CoreDataProperties.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 04/02/21.
//  Copyright © 2021 Helaine Pontes. All rights reserved.
//
//

import Foundation
import CoreData

extension MealPersistence {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealPersistence> {
        return NSFetchRequest<MealPersistence>(entityName: "MealPersistence")
    }

    @NSManaged public var name: String?

}

extension MealPersistence: Identifiable {}
