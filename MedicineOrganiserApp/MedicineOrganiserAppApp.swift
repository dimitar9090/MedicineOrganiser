import SwiftUI
import UserNotifications

@main
struct MedicineOrganiserAppApp: App {
    @UIApplicationDelegateAdaptor(MainAppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ReminderView() // Your main content view
        }
    }
}
