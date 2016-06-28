//
//  Notification.swift
//  ForSubway
//
//  Created by Gabriel Cavalcante on 6/28/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import Foundation
import UIKit

public class Notification{
    
    func createNotification(station: Station){
        
        let notificationArrival = UILocalNotification()
        notificationArrival.fireDate = station.arrivalTime
        notificationArrival.alertTitle = "Metro ForSubway!"
        notificationArrival.alertBody = "Metro has come - \(station.arrivalTime)"
        notificationArrival.applicationIconBadgeNumber = (UIApplication.sharedApplication().scheduledLocalNotifications?.count)! + 1
        notificationArrival.soundName = UILocalNotificationDefaultSoundName
        
        let notificationDeparture = UILocalNotification()
        notificationDeparture.fireDate = station.departureTime
        notificationDeparture.alertTitle = "Metro ForSubway!"
        notificationDeparture.alertBody = "Metro is going - \(station.departureTime)"
        notificationDeparture.applicationIconBadgeNumber = (UIApplication.sharedApplication().scheduledLocalNotifications?.count)! + 1
        notificationDeparture.soundName = UILocalNotificationDefaultSoundName
        
    }
    
    func cancelNotification(station: Station){
        
        let arrayNotification = UIApplication.sharedApplication().scheduledLocalNotifications
        
        for notification in arrayNotification! where station.arrivalTime == notification.fireDate || station.departureTime == notification.fireDate {
            
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        
    }
    
    func cancelAllNotifications(){
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
}