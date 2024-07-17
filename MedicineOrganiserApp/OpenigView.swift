import SwiftUI

struct OpenigView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 50) { // Add spacing between NavigationLinks
                NavigationLink(destination: MedicineEntriesListView()) {
                    Text("Storing Medicines")
                        .padding()
                        .foregroundColor(.white) // Text color
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue) // Button background color
                        .cornerRadius(10) // Rounded corners
                }
                .padding(.horizontal, 40) // Horizontal padding
                
                NavigationLink(destination: ReminderView()) {
                    Text("Medicine Reminder")
                        .padding()
                        .foregroundColor(.white) // Text color
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity)
                        .background(Color.green) // Button background color
                        .cornerRadius(10) // Rounded corners
                }
                .padding(.horizontal, 40) // Horizontal padding
            }
            .navigationTitle("Medicine Organiser")
            .background(Color(UIColor.systemBackground)) // Background color of the view
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use StackNavigationViewStyle for better spacing in VStack
    }
}

#if DEBUG
struct OpenigView_Previews: PreviewProvider {
    static var previews: some View {
        OpenigView()
    }
}
#endif
