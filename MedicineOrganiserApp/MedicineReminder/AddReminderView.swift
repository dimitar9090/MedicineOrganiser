import SwiftUI

struct AddReminderView: View {
    @ObservedObject var reminderList: ReminderList
    @State private var name = ""
    @State private var dosage = ""
    @State private var timeOfDay = Date()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Dosage", text: $dosage)
                DatePicker("Time of Day", selection: $timeOfDay, displayedComponents: .hourAndMinute)
            }
            .navigationTitle("Add Reminder")
            .navigationBarItems(trailing: Button("Save") {
                let newReminder = Reminder(name: name, dosage: dosage, timeOfDay: timeOfDay)
                reminderList.reminders.append(newReminder)
                NotificationManager().scheduleNotification(reminder: newReminder)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView(reminderList: ReminderList())
    }
}
