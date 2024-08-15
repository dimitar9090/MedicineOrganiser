import SwiftUI
import UserNotifications

@main
struct MedicineOrganiserAppApp: App {
    @UIApplicationDelegateAdaptor(MainAppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            OpenigView() // Your main content view
        }
    }
}
