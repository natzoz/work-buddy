import SwiftUI

@main
struct WorkBuddyApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                TaskPage()
            }.environmentObject(listViewModel)
        }
    }
}
