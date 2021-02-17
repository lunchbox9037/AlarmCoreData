//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by stanley phillips on 1/21/21.
//

import CoreData

class AlarmController {
    static var shared = AlarmController()
    let alarmScheduler = AlarmScheduler()
    var alarms: [Alarm] {
        let alarms = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        return alarms
    }
    
    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    func createAlarmWith(title: String, fireDate: Date) {
        let alarm = Alarm(title: title, fireDate: fireDate)
        alarmScheduler.scheduleNotifications(alarm: alarm)
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        alarmScheduler.cancelNotification(alarm: alarm)
        alarmScheduler.scheduleNotifications(alarm: alarm)
        saveToPersistentStore()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        if alarm.isEnabled {
            alarmScheduler.scheduleNotifications(alarm: alarm)
        } else {
            alarmScheduler.cancelNotification(alarm: alarm)
        }
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm) {
        CoreDataStack.context.delete(alarm)
        alarmScheduler.cancelNotification(alarm: alarm)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        CoreDataStack.saveContext()
    }
}
