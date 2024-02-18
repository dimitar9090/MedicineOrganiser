import SwiftUI

struct CreateMedicineEntryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var date: Date = Date()
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Quantity", text: $quantity)
                DatePicker("Expire Date", selection: $date, displayedComponents: .date)
                
               
            }
            .background(CustomBackgroundView())
            .scrollContentBackground(.hidden)
            .navigationTitle("New Medicine Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        
                        let newMedicineEntry = MedicineEntry(name: name, quantity: quantity, date: date)
                        modelContext.insert(newMedicineEntry)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CreateMedicineEntryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMedicineEntryView()
    }
}


