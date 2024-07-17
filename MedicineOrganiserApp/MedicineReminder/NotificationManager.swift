import UserNotifications

class NotificationManager {
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Authorization Error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Medicine Reminder"
        content.body = "Time to take \(reminder.name)"
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminder.timeOfDay) // Changed to let
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: \(error.localizedDescription)")
            }
        }
    }
}
