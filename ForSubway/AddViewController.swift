//
//  AddViewController.swift
//  ForSubway
//
//  Created by Pedro Albuquerque on 27/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    @IBOutlet weak var textArrivalTime: UITextField!
    
    @IBOutlet weak var textDepartureTime: UITextField!
    
    @IBOutlet weak var textName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Station", inManagedObjectContext: managedContext)
        
        let station = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        station.setValue(textName.text, forKey: "name")
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        
        station.setValue(formatter.dateFromString(textArrivalTime.text!), forKey: "arrivalTime")
        station.setValue(formatter.dateFromString(textDepartureTime.text!), forKey: "departureTime")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        self.navigationController?.popViewControllerAnimated(true);
    }
}
