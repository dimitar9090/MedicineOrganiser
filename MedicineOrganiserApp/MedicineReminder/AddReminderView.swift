import SwiftUI

struct AddReminderView: View {
    @ObservedObject var reminderList: ReminderList
    @State private var name = ""
    @State private var dosage = ""
    @State private var timesOfDay: [Date] = [Date()]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Dosage", text: $dosage)
                    .keyboardType(.numberPad)
                    .onChange(of: dosage) { newValue in
                        updateTimesOfDay()
                    }
                
                Section(header: Text("Times of Day")) {
                    ForEach(timesOfDay.indices, id: \.self) { index in
                        DatePicker("Dosage \(index + 1)", selection: $timesOfDay[index], displayedComponents: .hourAndMinute)
                    }
                }
                
                Button(action: addTimeOfDay) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Time")
                    }
                }
            }
            .navigationTitle("Add Reminder")
            .navigationBarItems(trailing: Button("Save") {
                saveReminder()
            })
        }
        .onChange(of: dosage) { _ in
            updateTimesOfDay()
        }
    }
    
    private func updateTimesOfDay() {
        if let newDosage = Int(dosage) {
            if newDosage > timesOfDay.count {
                for _ in timesOfDay.count..<newDosage {
                    timesOfDay.append(Date())
                }
            } else if newDosage < timesOfDay.count {
                timesOfDay.removeLast(timesOfDay.count - newDosage)
            }
        }
    }
    
    private func addTimeOfDay() {
        timesOfDay.append(Date())
    }
    
    private func saveReminder() {
        let newReminder = Reminder(name: name, dosage: dosage, timesOfDay: timesOfDay)
        reminderList.reminders.append(newReminder)
        NotificationManager().scheduleNotifications(for: newReminder)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView(reminderList: ReminderList())
    }
}
