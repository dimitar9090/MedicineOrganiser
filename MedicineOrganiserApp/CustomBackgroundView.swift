//
//  CustomBackgroundView.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 19.11.23.
//

import SwiftUI

struct CustomBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
            Color(red: 1.0, green: 0.5, blue: 0.8), // Pink
            Color(red: 0.6, green: 0.4, blue: 0.8)  // Purple
        ]),
        startPoint: .top,
        endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct CustomBackgroundView_Previews: PreviewProvider {
    static var previews: some View{
        CustomBackgroundView()
    }
}
