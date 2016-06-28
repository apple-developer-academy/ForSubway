//
//  StationDAO.swift
//  ForSubway
//
//  Created by Gabriel Cavalcante on 28/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

public class StationDAO{
    
    private var appDelegate: AppDelegate
    private var managedContext: NSManagedObjectContext
    private var entity: NSEntityDescription
    private var fetchRequest: NSFetchRequest
    private var station: Station
    
    init(){
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
        entity = NSEntityDescription.entityForName("Station", inManagedObjectContext: managedContext)!
        fetchRequest = NSFetchRequest(entityName: "Station")
        station = Station(entity: entity, insertIntoManagedObjectContext: managedContext)
    }
    
    func fetch() -> [Station]{
        
        var allStations = [Station]()
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            allStations = results as! [Station]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

        
        return allStations
    }
    
    func create(name: String, arrivalTime: NSDate, departureTime: NSDate){
        
        station.name = name
        
        station.arrivalTime = arrivalTime
        
        station.departureTime = departureTime
        
        saveContext()
    }
    
    func remove(station: Station){
        
        managedContext.deleteObject(station)
        
        saveContext()
    
    }
    
    func removeAll(){
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let station:Station = managedObject as! Station
                managedContext.deleteObject(station)
            }
        } catch let error as NSError {
            print("Detele all data in Station error : \(error) \(error.userInfo)")
        }

        saveContext()
    }
    
    func saveContext(){
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}
