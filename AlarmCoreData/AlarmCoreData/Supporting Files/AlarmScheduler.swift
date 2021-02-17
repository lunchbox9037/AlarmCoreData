//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by stanley phillips on 1/21/21.
//

import UserNotifications

class AlarmScheduler {
    func scheduleNotifications(alarm: Alarm) {
        guard let date = alarm.fireDate,
              let id = alarm.uuidString else {return}
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "WAKE UP!"
        content.sound = .default
        
        //create the trigger for the notification
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //create the request
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        
        //add the request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")

            }
        }
    }
    
    func cancelNotification(alarm: Alarm) {
        guard let id = alarm.uuidString else {return}
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
