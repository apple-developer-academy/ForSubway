//
//  ViewController.swift
//  ForSubway
//
//  Created by Pedro Albuquerque on 27/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var allStations = [Station]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false;
        
        self.populateTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    
        self.populateTable()
    }
    
    func populateTable(){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Station")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            allStations = results as! [Station]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return allStations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CellViewController
        
        let station = allStations[indexPath.row]
        
        cell.labelName.text = station.name
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = ("HH:mm")
        
        cell.labelArrivalTime.text = formatter.stringFromDate(station.arrivalTime!)
        cell.labelDepartureTime.text = formatter.stringFromDate(station.departureTime!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            
            // remove the deleted item from the model
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let context: NSManagedObjectContext = appDelegate.managedObjectContext
            
            context.deleteObject(allStations[indexPath.row])
            allStations.removeAtIndex(indexPath.row)
            
            do {
                try context.save()
            } catch _ {
            
            }
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }

    @IBAction func removeAll(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Station")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in Station error : \(error) \(error.userInfo)")
        }
        
        self.populateTable()
    }
}

