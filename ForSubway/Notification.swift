//
//  Notification.swift
//  ForSubway
//
//  Created by Gabriel Cavalcante on 6/28/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit

public class Notification{
    
    //Crie 3 funcoes para trabalhar com as Local Notifications
    
    //createNotification
    //cancelNotification
    //cancelAllNotifications
    
    //////////////////LOCAL DAS FUNCOES//////////////////
    
    func createNotification(arrival: NSDate, departure: NSDate) {
        let notificationArrival:UILocalNotification = UILocalNotification()
        notificationArrival.fireDate = arrival
        notificationArrival.alertTitle = "Metro ForSubway!"
        notificationArrival.alertBody = "Metro has come at \(dateNotification(arrival))"
        notificationArrival.applicationIconBadgeNumber = (UIApplication.sharedApplication().scheduledLocalNotifications?.count)! + 1
        notificationArrival.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notificationArrival)
        
        let notificationDeparture:UILocalNotification = UILocalNotification()
        notificationDeparture.fireDate = departure
        notificationDeparture.alertTitle = "Metro ForSubway!"
        notificationDeparture.alertBody = "Metro is going at \(dateNotification(departure))"
        notificationDeparture.applicationIconBadgeNumber = (UIApplication.sharedApplication().scheduledLocalNotifications?.count)! + 1
        notificationDeparture.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notificationDeparture)
    }
    
    func cancelNotification(arrival: NSDate, departure: NSDate) {
        let arrayNotification = UIApplication.sharedApplication().scheduledLocalNotifications
        
        for notification in arrayNotification! where arrival == notification.fireDate || departure == notification.fireDate {
            
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        
    }
    
    func cancelAllNotifications() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    //////////////////LOCAL DAS FUNCOES//////////////////
    
    //Deixando a demonstracao da data mais legivel
    func dateNotification(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm - dd/MM/yyyy"
        return formatter.stringFromDate(date)
    }
}