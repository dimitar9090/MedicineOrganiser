import SwiftUI

struct OpenigView: View {
    var body: some View {
        NavigationView {
            ZStack {
               CustomBackgroundView() // Clearly visible purple background
                    .ignoresSafeArea() // Extend color to the edges of the screen
                
                VStack(spacing: 50) {
                    
                    
                    
                    NavigationLink(destination: MedicineEntriesListView()) {
                        Text("Storing Medicines")
                            .padding()
                            .foregroundColor(.white) // Text color
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.6, green: 0.4, blue: 0.8)) // Button background color
                            .cornerRadius(10) // Rounded corners
                    }
                    .padding(.horizontal, 40) // Horizontal padding
                    
                    NavigationLink(destination: ReminderView()) {
                        Text("Medicine Reminder")
                            .padding()
                            .foregroundColor(.white) // Text color
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background( Color(red: 1.0, green: 0.5, blue: 0.8)) // Button background color
                            .cornerRadius(10) // Rounded corners
                    }
                    .padding(.horizontal, 40) // Horizontal padding
                    
                    NavigationLink(destination: APIView()) {
                        Text("Drugs Info")
                            .padding()
                            .foregroundColor(.white) // Text color
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue) // Button background color
                            .cornerRadius(10) // Rounded corners
                    }
                    .padding(.horizontal, 40) // Horizontal padding
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "pills.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Medicine Organiser")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
struct OpenigView_Previews: PreviewProvider {
    static var previews: some View {
        OpenigView()
    }
}
#endif
