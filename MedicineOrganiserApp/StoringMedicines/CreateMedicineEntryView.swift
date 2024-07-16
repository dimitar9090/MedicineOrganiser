import SwiftUI

// The view for creating a new medicine entry
struct CreateMedicineEntryView: View {
    
    // Access to the model context environment variable for data management
    @Environment(\.modelContext) private var modelContext
    
    // Environment variable to handle view dismissal
    @Environment(\.dismiss) var dismiss
    
    // State variables to manage form data and UI states
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var date: Date = Date()
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        
        // NavigationStack provides navigation functionality within the view
        NavigationStack {
            // Form layout for input fields
            Form {
                // Text field for medicine name input
                TextField("Name", text: $name)
                // Text field for medicine quantity input
                TextField("Quantity", text: $quantity)
                // Date picker for selecting the expiration date
                DatePicker("Expire Date", selection: $date, displayedComponents: .date)
            }
            .background(CustomBackgroundView()) // Custom background view
            .scrollContentBackground(.hidden) // Hide the default scroll view background
            .navigationTitle("New Medicine Entry") // Title of the navigation bar
            .toolbar {
                // Toolbar item for the cancel button, placed on the leading side
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss() // Dismiss the view when cancel is tapped
                    }
                }
                // Toolbar item for the save button, placed on the trailing side
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Create a new MedicineEntry instance with the input data
                        let newMedicineEntry = MedicineEntry(name: name, quantity: quantity, date: date)
                        // Insert the new entry into the model context
                        modelContext.insert(newMedicineEntry)
                        // Dismiss the view after saving
                        dismiss()
                    }
                }
            }
        }
    }
}

// Preview provider for SwiftUI previews in Xcode
struct CreateMedicineEntryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMedicineEntryView()
    }
}
