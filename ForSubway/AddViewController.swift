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
    @IBOutlet weak var imageSubway: UIImageView!
    
    @IBOutlet weak var textArrivalTime: UITextField!
    @IBOutlet weak var textDepartureTime: UITextField!
    @IBOutlet weak var textName: UITextField!
    
    var popDatePicker: PopDatePicker?
    var stationDAO = StationDAO()
    var notification = Notification()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Arredondando imagem do subway
        imageSubway.layer.cornerRadius = imageSubway.frame.size.width/2
        imageSubway.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Utilizando Text Field Delegate para chamar o Pop Date Picker
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == textArrivalTime || textField == textDepartureTime{
            
            popDatePicker = PopDatePicker(forTextField: textField)
            textField.resignFirstResponder()
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .MediumStyle
            
            let initDate = NSDate()
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
            }
            
            popDatePicker!.pick(self, initDate: initDate, modePicker: UIDatePickerMode.DateAndTime, dateMin: "27-06-2016 06:00", dateMax: "20-08-2016 23:00", dataChanged: dataChangedCallback)
            
            return false
        } else {
            return true
        }
    }
    
    //Salvando a Station e criando a notification
    @IBAction func saveAction(sender: AnyObject) {
        //Verificando se os campos estao preenchidos e setando Alert Controller
        if textDepartureTime.text == "" || textName.text == "" || textArrivalTime.text == "" {
            let alert = UIAlertController(title: "Empty TextField", message: "Fill correctly the empty space.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let arrivalTime = saveDateNotification(textArrivalTime.text!)
            let departureTime = saveDateNotification(textDepartureTime.text!)
            
            stationDAO.create(textName.text!, arrivalTime: arrivalTime!, departureTime: departureTime!)
            
            ///////////////Criar a notificacao da hora de chegada e de partida///////////////
            
            
            
            /////////////////////////////////////////////////////////////////////////////////
            
            //Dando pop na Push View
            if let navigation = self.navigationController {
                navigation.popViewControllerAnimated(true)
            }
        }
    }
    
    //Cancelando cadastro de Station
    @IBAction func cancelAction(sender: AnyObject) {
        if let navigation = self.navigationController {
            navigation.popViewControllerAnimated(true)
        }
    }

    //Salvando a data atraves do textField
    func saveDateNotification(date: String) -> NSDate? {
        let formatterDate = NSDateFormatter()
        formatterDate.dateFormat = "dd-MM-yyyy HH:mm"
        
        let dateNotification = formatterDate.dateFromString(date)
        
        return dateNotification
    }

}
