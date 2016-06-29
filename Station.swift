//
//  Station.swift
//  ForSubway
//
//  Created by Gabriel Cavalcante on 27/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import Foundation
import CoreData

@objc(Station)
class Station: NSManagedObject {
    @NSManaged var arrivalTime: NSDate
    @NSManaged var departureTime: NSDate
    @NSManaged var name: String
}
