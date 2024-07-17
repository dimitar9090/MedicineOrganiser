import SwiftUI
import SwiftData

@main
struct MedicineOrganiserAppApp: App {
    
    let sharedModelContainer: ModelContainer
    
    init() {
        let schema = Schema([
            MedicineEntry.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create Modelcontainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            OpenigView()
                .modelContainer(sharedModelContainer)
        }
    }
}
