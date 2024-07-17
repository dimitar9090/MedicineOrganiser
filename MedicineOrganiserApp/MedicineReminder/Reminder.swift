import Foundation

struct Reminder: Identifiable, Codable {
    var id: UUID
    var name: String
    var dosage: String
    var timesOfDay: [Date]
    
    init(id: UUID = UUID(), name: String, dosage: String, timesOfDay: [Date]) {
        self.id = id
        self.name = name
        self.dosage = dosage
        self.timesOfDay = timesOfDay
    }
}
