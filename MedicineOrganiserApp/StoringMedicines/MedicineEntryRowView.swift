//
//  MedicineEntryRowView.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 16.11.23.
//
import SwiftUI

struct MedicineEntryRowView: View {
    let rowMedicineEntry: MedicineEntry
    let isExpired: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(rowMedicineEntry.name)
                    .bold()
                    .font(.title)
                Text("-")
                Text(rowMedicineEntry.quantity)
                    .font(.title2)
            }
            HStack {
                Text(rowMedicineEntry.date, style: .date)
                    .bold()
            }
        }
        .padding() // Add padding to ensure content does not touch the edges.
        .frame(maxWidth: .infinity, alignment: .leading) // Ensure VStack takes full width.
        .background(isExpired ? Color.red : Color.blue) // Set background color based on expiration
        .cornerRadius(10)
        .listRowInsets(EdgeInsets()) // Remove default list row padding
        .listRowBackground(isExpired ? Color.red : Color.blue) // Ensure full row background color in List
        
    }
}



#Preview {
    List{
        MedicineEntryRowView(rowMedicineEntry: MedicineEntry(name: "Analgin", quantity: "5", date: Date()), isExpired: true)
    }
}
