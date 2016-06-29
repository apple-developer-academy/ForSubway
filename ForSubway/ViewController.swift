//
//  ViewController.swift
//  ForSubway
//
//  Created by Gabriel Cavalcante on 27/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var trashBar: UIBarButtonItem!
    
    var allStations = [Station]()
    
    var notification = Notification()
    
    var stationDAO = StationDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false;
        
        populateTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    
        self.populateTable()
        tableView.reloadData()
    }
    
    func checkTrash() {
        if allStations.isEmpty{
            trashBar.enabled = false
        }else{
            trashBar.enabled = true
        }
    }
    
    func populateTable(){
        allStations = stationDAO.fetchAllStations()
        
        checkTrash()
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
        
        cell.labelArrivalTime.text = formatter.stringFromDate(station.arrivalTime)
        cell.labelDepartureTime.text = formatter.stringFromDate(station.departureTime)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            let station = allStations[indexPath.row]
            
            allStations.removeAtIndex(indexPath.row)
            
            stationDAO.remove(station)
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            checkTrash()
        default:
            return
        }
    }
    
    @IBAction func removeAll(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Remove All Stations", message: "Would you like to remove all Stations from Subway?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.Destructive, handler:{ action in
            self.stationDAO.removeAll()
            
            self.notification.cancelAllNotifications()
            
            self.populateTable()
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}

