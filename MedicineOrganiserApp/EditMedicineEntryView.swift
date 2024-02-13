//
//  EditMedicineentryView.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 17.11.23.
//

import SwiftUI

struct EditMedicineEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    
    @State var editingMedicineEntry: MedicineEntry
    @State var editMode = true

    var body: some View {
        if editMode {
            Form{
                TextField("Name", text: $editingMedicineEntry.name)
                TextField("Quantity", text: $editingMedicineEntry.quantity)
                DatePicker("Expire Date", selection: $editingMedicineEntry.date, displayedComponents: .date)
            }.background(CustomBackgroundView())
                .scrollContentBackground(.hidden)
            .navigationTitle("Edit Mode")
            .toolbar {
                Button("Delete") {
                    modelContext.delete(editingMedicineEntry)
                    dismiss()
                }
                .foregroundColor(.red)
                Button("Done") {
                    editMode = false
                }
            }
        } else {
            MedicineEntryDetailView(detailMedicineEntry: editingMedicineEntry)
                .toolbar {
                    Button("Edit") {
                        editMode = true
                    }
                }
        }
    }
}

#Preview {
    NavigationStack {
        EditMedicineEntryView(editingMedicineEntry: MedicineEntry(name: "Analgin", quantity: "5", date: Date()))
    }
}
