//
//  MedicineEntryDetailView.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 16.11.23.
//

import SwiftUI

struct MedicineEntryDetailView: View {
    
    let detailMedicineEntry: MedicineEntry
    
    var body: some View {
        ZStack {
            CustomBackgroundView()
            VStack{
                Text(detailMedicineEntry.quantity)
                    .bold()
                    .font(.title)
                    .italic()
                    .padding()
                Text(detailMedicineEntry.date, style: .date)
                    .bold()
                    .italic()
            }
            .navigationTitle(detailMedicineEntry.name)
            
        }
}
    }
        

#Preview {
    MedicineEntryDetailView(detailMedicineEntry: MedicineEntry(name: "Analgin", quantity: "5", date: Date()))
}
