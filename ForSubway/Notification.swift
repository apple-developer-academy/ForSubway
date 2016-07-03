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
    
    //createNotification - Deve receber NSDate do horario de chegada e partida
    //cancelNotification - Deve receber NSDate do horario de chegada e partida
    //cancelAllNotifications - Nao recebe nada, apenas cancela todas as notificacoes
    
    //////////////////LOCAL DAS FUNCOES//////////////////
    
    
    
    
    
    
    
    /////////////////////////////////////////////////////
    
    //Deixando a demonstracao da data mais legivel
    func dateNotification(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm - dd/MM/yyyy"
        return formatter.stringFromDate(date)
    }
}