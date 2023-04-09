//
//  WorkBuddyApp.swift
//  WorkBuddy
//
//  Created by cs-488-01 on 4/8/23.
//

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
