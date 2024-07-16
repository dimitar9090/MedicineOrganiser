//
//  OpenigView.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 16.07.24.
//

import SwiftUI

struct OpenigView: View {
    var body: some View {
        NavigationView { // Begins the NavigationView
            VStack {
                NavigationLink(destination: MedicineEntriesListView()) {
                    Text("Go to First View")
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding()
                
                NavigationLink(destination: Text("Second View")) {
                    Text("Go to Second View")
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationTitle("Navigation Example") // Sets the title of the navigation bar
        } // Ends the NavigationView
    } // Ends the body of the view
} // Ends the OpenigView struct

#if DEBUG
struct OpenigView_Previews: PreviewProvider {
    static var previews: some View {
        OpenigView() // Preview for OpenigView
    }
}
#endif
