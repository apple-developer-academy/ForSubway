//
//  AddViewController.swift
//  ForSubway
//
//  Created by Gabriel Cavalcante on 27/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textArrivalTime: UITextField!
    
    @IBOutlet weak var textDepartureTime: UITextField!
    
    @IBOutlet weak var textName: UITextField!
    
    var popDatePicker: PopDatePicker?
    
    var notification = Notification()
    
    var stationDAO = StationDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.backBarButtonItem?.title = ""
        navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
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
            
            let initDate = NSDate()
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
                
                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
                
            }
            
            popDatePicker!.pick(self, initDate: initDate, modePicker: UIDatePickerMode.Time, dateMin: "27-06-2016 06:00", dateMax: "10-07-2050 23:00", dataChanged: dataChangedCallback)
            return false
        } else {
            return true
        }
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        
        if textDepartureTime.text == "" || textName.text == "" || textArrivalTime.text == ""{
        
            let alert = UIAlertController(title: "Empty TextField", message: "Fill correctly the empty space.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else{
            
            let arrivalTime = saveDateNotification(textArrivalTime.text!)
            let departureTime = saveDateNotification(textDepartureTime.text!)
            
            stationDAO.create(textName.text!, arrivalTime: arrivalTime!, departureTime: departureTime!)
            
            print("Arrival Time = \(arrivalTime)")
            print("Departure Time = \(departureTime)")
            
            notification.createNotification(arrivalTime!, departure: departureTime!)
            
            if let navigation = self.navigationController {
                navigation.popViewControllerAnimated(true)
            }
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        if let navigation = self.navigationController {
            navigation.popViewControllerAnimated(true)
        }
    }
    
    func saveDateNotification(hour: String) -> NSDate? {
        let currentDate = NSDate()
        
        let formatterDay = NSDateFormatter()
        formatterDay.dateFormat = "dd-MM-yyyy"
        
        let day = formatterDay.stringFromDate(currentDate)
        
        let stringDate = "\(day) \(hour)"
        
        print(stringDate)
        
        let formatterDate = NSDateFormatter()
        formatterDate.dateFormat = "dd-MM-yyyy HH:mm"
        
        let dateNotification = formatterDate.dateFromString(stringDate)
        
        return dateNotification
    }

}
