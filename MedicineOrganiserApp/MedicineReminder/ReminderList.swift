import Foundation

class ReminderList: ObservableObject {
    @Published var reminders: [Reminder] = [] {
        didSet {
            saveReminders()
        }
    }
    
    init() {
        loadReminders()
    }
    
    func saveReminders() {
        if let encoded = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(encoded, forKey: "reminders")
        }
    }
    
    func loadReminders() {
        if let savedReminders = UserDefaults.standard.data(forKey: "reminders") {
            if let decodedReminders = try? JSONDecoder().decode([Reminder].self, from: savedReminders) {
                reminders = decodedReminders
            }
        }
    }
}
