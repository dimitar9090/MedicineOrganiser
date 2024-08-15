import SwiftUI

struct ReminderView: View {
    @ObservedObject var reminderList = ReminderList()
    @State private var showingAddReminder = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(reminderList.reminders) { reminder in
                    VStack(alignment: .leading) {
                        Text(reminder.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Dosage: \(reminder.dosage)")
                            .foregroundColor(.white)
                        ForEach(reminder.timesOfDay, id: \.self) { time in
                            Text("Time: \(time, formatter: DateFormatter.timeFormatter)")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .onDelete { indexSet in
                    reminderList.reminders.remove(atOffsets: indexSet)
                }
                .listRowBackground(Color.purple)
            }
            .background(CustomBackgroundView())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "pills.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Reminders")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                showingAddReminder = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            })
            .sheet(isPresented: $showingAddReminder) {
                AddReminderView(reminderList: reminderList)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
    }
}

extension DateFormatter {
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
