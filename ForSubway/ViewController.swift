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
    var stationDAO = StationDAO()
    var notification = Notification()
    
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
    
    //Chegando se existe dados na Table View
    func checkTrash() {
        if allStations.isEmpty{
            trashBar.enabled = false
        }else{
            trashBar.enabled = true
        }
    }
    
    //Populando tabela atraves do Core Data
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
        
        var text = formatter.stringFromDate(station.arrivalTime)
        print("TEXTTTTTTTTTT \(text)")
        cell.labelArrivalTime.text = text
        
        text = formatter.stringFromDate(station.departureTime)
        cell.labelDepartureTime.text = text
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //Removendo linha da Table View com Editing Style
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            let station = allStations[indexPath.row]
            
            /////////////Cancelar a notificacao da Station selecionada//////////////
            
            notification.cancelNotification(station.arrivalTime, departure: station.departureTime)
            
            ////////////////////////////////////////////////////////////////////////
            
            allStations.removeAtIndex(indexPath.row)
            
            stationDAO.remove(station)
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            checkTrash()
        default:
            return
        }
    }
    
    //Removendo todas as linhas da Table View
    @IBAction func removeAll(sender: AnyObject) {
        let alert = UIAlertController(title: "Remove All Stations", message: "Would you like to remove all Stations from Subway?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.Destructive, handler:{ action in
            self.stationDAO.removeAll()
            
            /////////////Cancelar todas notificacoes///////////////
            
            self.notification.cancelAllNotifications()
            
            ///////////////////////////////////////////////////////
            
            self.populateTable()
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}

