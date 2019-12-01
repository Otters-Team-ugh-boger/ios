//
//  File.swift
//  ios
//
//  Created by vladislav on 01.12.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
  
  let notificationCenter = UNUserNotificationCenter.current()
  let userDefaults = UserDefaults.standard
  
  func notificationRequest() {
    let options: UNAuthorizationOptions = [.alert, .sound]
    
    notificationCenter.requestAuthorization(options: options) { (granted, error) in
      
    }
  }
  
  func scheduleNotification(time: Date, completion: (Bool) -> ()) {
    removeNotifications(withIdentifiers: ["Identifier"])
    
    let userActions = "User Actions"
    let content = UNMutableNotificationContent()
    content.title = "Alarm"
    content.body = "WAKE UP"
    content.sound = UNNotificationSound.default
    
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.hour, .minute], from: time)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
    let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
    
    notificationCenter.add(request, withCompletionHandler: nil)
    
    let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
    let category = UNNotificationCategory(identifier: userActions,
                                                       actions: [deleteAction],
                                                       intentIdentifiers: [],
                                                       options: [])
           
    notificationCenter.setNotificationCategories([category])
  }
  
  func removeNotifications(withIdentifiers identifiers: [String]) {
    notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent willPresentnotification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
    completionHandler([.alert, .sound])
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
      
      if response.notification.request.identifier == "Local Notification" {
          print("Handling notifications with the Local Notification Identifier")
      }
      
      switch response.actionIdentifier {
      case "Delete":
        
          print("Delete")
      default:
          print("Unknown action")
      }
      completionHandler()
  }
  
}
