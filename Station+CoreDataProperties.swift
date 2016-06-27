//
//  Station+CoreDataProperties.swift
//  ForSubway
//
//  Created by Pedro Albuquerque on 27/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Station {

    @NSManaged var arrivalTime: NSDate?
    @NSManaged var departureTime: NSDate?
    @NSManaged var name: String?

}
