//
//  AddViewController.swift
//  ForSubway
//
//  Created by Pedro Albuquerque on 27/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textArrivalTime: UITextField!
    
    @IBOutlet weak var textDepartureTime: UITextField!
    
    @IBOutlet weak var textName: UITextField!
    
    var popDatePicker: PopDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField == textArrivalTime || textField == textDepartureTime{
            
            popDatePicker = PopDatePicker(forTextField: textField)
            textField.resignFirstResponder()
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .NoStyle
            formatter.timeStyle = .MediumStyle
            
            let initDate: NSDate? = formatter.dateFromString(textField.text!)
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
                
                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
                
            }
            
            popDatePicker!.pick(self, initDate: initDate, modePicker: UIDatePickerMode.Time, dateMin: "27-06-2016 06:00", dateMax: "10-07-2016 23:00", dataChanged: dataChangedCallback)
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        
        if textDepartureTime.text == "" || textName.text == "" || textArrivalTime.text == ""{
        
            let alert = UIAlertController(title: "Empty TextField", message: "Fill correctly the empty space.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else{
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
}
