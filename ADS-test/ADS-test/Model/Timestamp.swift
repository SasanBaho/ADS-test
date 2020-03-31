//
//  Timestamp.swift
//  ADS-test
//
//  Created by Sasan Baho on 2020-03-28.
//  Copyright © 2020 Sasan Baho. All rights reserved.
//
import UIKit

class Timestamp {
    
    let now = Date()
    let formatter = DateFormatter()
    let notifiName = "timestamp"
    static var newTime = [String : String]()
    
    //Generate timestamp
    func generateTime() -> [String : String]{
       formatter.timeZone = TimeZone.current
       formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       let dateString = formatter.string(from: now)
       Timestamp.newTime["timestamp"] = dateString
        return Timestamp.newTime
    }
    
    func timeUpdatePost(){
        NotificationCenter.default.post(name: Notification.Name(notifiName), object: self, userInfo: Timestamp.newTime)
    }
    

}
