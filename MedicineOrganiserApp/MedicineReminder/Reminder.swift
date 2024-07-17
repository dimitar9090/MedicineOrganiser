import Foundation

struct Reminder: Identifiable, Codable {
    var id: UUID
    var name: String
    var dosage: String
    var timeOfDay: Date
    
    init(id: UUID = UUID(), name: String, dosage: String, timeOfDay: Date) {
        self.id = id
        self.name = name
        self.dosage = dosage
        self.timeOfDay = timeOfDay
    }
}
