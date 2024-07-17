//
//  SwiftUIView.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 17.07.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var reminderList = ReminderList()
    @State private var showingAddReminder = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(reminderList.reminders) { reminder in
                    VStack(alignment: .leading) {
                        Text(reminder.name)
                            .font(.headline)
                        Text("Dosage: \(reminder.dosage)")
                        Text("Time: \(reminder.timeOfDay, formatter: DateFormatter.timeFormatter)")
                    }
                }
                .onDelete { indexSet in
                    reminderList.reminders.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Reminders")
            .navigationBarItems(trailing: Button(action: {
                showingAddReminder = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddReminder) {
                AddReminderView(reminderList: reminderList)
            }
        }
    }
}

extension DateFormatter {
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
