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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isExpired ? Color.red.opacity(1.0) : Color.blue) // Set background color based on expiration
        .cornerRadius(10)
    }
}



#Preview {
    List{
        MedicineEntryRowView(rowMedicineEntry: MedicineEntry(name: "Analgin", quantity: "5", date: Date()), isExpired: true)
    }
}
