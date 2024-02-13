import SwiftUI

struct MedicineEntryDetailView: View {
    
    let detailMedicineEntry: MedicineEntry
    
    var body: some View {
        ZStack {
            CustomBackgroundView() // Assuming this is a custom view for background styling
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    

                    Divider()

                    HStack {
                        Text("Name:")
                            .bold()
                        Spacer()
                        Text(detailMedicineEntry.name)
                    }
                    .font(.title2)
                    .padding(.horizontal)

                    HStack {
                        Text("Quantity:")
                            .bold()
                        Spacer()
                        Text("\(detailMedicineEntry.quantity)")
                    }
                    .font(.title2)
                    .padding(.horizontal)

                    HStack {
                        Text("Expiration Date:")
                            .bold()
                        Spacer()
                        Text(detailMedicineEntry.date, style: .date)
                    }
                    .font(.title2)
                    .padding(.horizontal)

                    Spacer() // Pushes everything to the top
                }
                .padding()
            }
            .navigationTitle("Medicine Details")
            .bold()
            .font(.largeTitle)
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
            .background(CustomBackgroundView().blur(radius: 10)) 
        }
    }
}


struct MedicineEntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MedicineEntryDetailView(detailMedicineEntry: MedicineEntry(name: "Analgin", quantity: "5 tablets", date: Date()))
        }
    }
}
