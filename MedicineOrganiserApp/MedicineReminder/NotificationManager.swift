import UserNotifications

class NotificationManager {
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Authorization Error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotifications(for reminder: Reminder) {
        for time in reminder.timesOfDay {
            let content = UNMutableNotificationContent()
            content.title = "Medicine Reminder"
            content.body = "Time to take \(reminder.name)"
            content.sound = .default
            
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Notification Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
