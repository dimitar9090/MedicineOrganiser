//
//  MedicineEntry.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 15.11.23.
//

import Foundation
import SwiftData

@Model
final class MedicineEntry {
     var name: String = ""
     var quantity: String = ""
     var date: Date = Date()
    
    init(name: String, quantity: String, date: Date) {
        self.name = name
        self.quantity = quantity
        self.date = date
    }
    }

