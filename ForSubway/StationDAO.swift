//
//  StationDAO.swift
//  ForSubway
//
//  Created by Gabriel Cavalcante on 28/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

public class StationDAO {
    
    private var appDelegate: AppDelegate
    private var managedContext: NSManagedObjectContext
    
    //Inicializando AppDelegate e NSManagedObjectContext
    init() {
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
    }
    
    //Buscando todas Stations pelo NSFetchRequest e retornando um array de Stations
    func fetchAllStations() -> [Station] {
        var allStations: [Station] = []
        
        do {
            let fetchRequest = NSFetchRequest(entityName: "Station")
            allStations = try managedContext.executeFetchRequest(fetchRequest) as! [Station]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return allStations
    }
    
    //Criando uma Station
    func create(name: String, arrivalTime: NSDate, departureTime: NSDate) {
        let description = NSEntityDescription.entityForName("Station", inManagedObjectContext: managedContext)!
        let station = Station(entity: description, insertIntoManagedObjectContext: managedContext)
        
        station.name = name
        station.arrivalTime = arrivalTime
        station.departureTime = departureTime
        
        saveContext()
    }
    
    //Removendo apenas uma Station
    func remove(station: Station) {
        managedContext.deleteObject(station)
        saveContext()
    }
    
    //Buscando e removendo todas Stations atraves do NSFetchRequest
    func removeAll() {
        let fetchRequest = NSFetchRequest(entityName: "Station")
        fetchRequest.returnsObjectsAsFaults = true
        
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

    //Salvando contexto do aplicativo com tratamento de erros
    func saveContext() {
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
