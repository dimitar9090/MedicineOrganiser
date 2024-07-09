import SwiftUI

// Define the MedicineEntryDetailView structure that conforms to the View protocol
struct MedicineEntryDetailView: View {
    
    // A MedicineEntry object that holds the details of the medicine entry
    let detailMedicineEntry: MedicineEntry
    
    var body: some View {
        ZStack {
            // Custom background view for styling purposes
            CustomBackgroundView()
            
            // Scrollable container to allow content to scroll if it exceeds screen size
            ScrollView {
                // Vertical stack to arrange elements vertically with specified spacing
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Divider to separate content sections
                    Divider()

                    // Horizontal stack to arrange elements horizontally
                    HStack {
                        // Text view for the label "Name:"
                        Text("Name:")
                            .bold() // Make the text bold
                        Spacer() // Push the next text to the end of the horizontal stack
                        // Text view to display the name of the medicine
                        Text(detailMedicineEntry.name)
                    } // End of HStack
                    .font(.title2) // Set the font size and style
                    .padding(.horizontal) // Add horizontal padding to the stack

                    // Horizontal stack for displaying the quantity of medicine
                    HStack {
                        // Text view for the label "Quantity:"
                        Text("Quantity:")
                            .bold() // Make the text bold
                        Spacer() // Push the next text to the end of the horizontal stack
                        // Text view to display the quantity of the medicine
                        Text("\(detailMedicineEntry.quantity)")
                    } // End of HStack
                    .font(.title2) // Set the font size and style
                    .padding(.horizontal) // Add horizontal padding to the stack

                    // Horizontal stack for displaying the expiration date of the medicine
                    HStack {
                        // Text view for the label "Expiration Date:"
                        Text("Expiration Date:")
                            .bold() // Make the text bold
                        Spacer() // Push the next text to the end of the horizontal stack
                        // Text view to display the expiration date of the medicine
                        Text(detailMedicineEntry.date, style: .date)
                    } // End of HStack
                    .font(.title2) // Set the font size and style
                    .padding(.horizontal) // Add horizontal padding to the stack

                    Spacer() // Pushes everything to the top
                } // End of VStack
                .padding() // Add padding around the VStack
            } // End of ScrollView
            .navigationTitle("Medicine Details") // Set the navigation title
            .bold() // Make the navigation title bold
            .font(.largeTitle) // Set the font size and style for the navigation title
            .padding(.top) // Add padding to the top of the scroll view
            .navigationBarTitleDisplayMode(.inline) // Set the navigation bar title display mode to inline
            .background(CustomBackgroundView().blur(radius: 10)) // Add a blurred custom background view
        } // End of ZStack
    } // End of body
} // End of MedicineEntryDetailView


// Preview provider for SwiftUI previews
struct MedicineEntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Embed the view in a NavigationView for preview
        NavigationView {
            // Provide a sample MedicineEntry object for preview purposes
            MedicineEntryDetailView(detailMedicineEntry: MedicineEntry(name: "Analgin", quantity: "5 tablets", date: Date()))
        }
    }
}
