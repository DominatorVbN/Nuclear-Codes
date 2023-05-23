//
//  NuclearCodesApp.swift
//  Nuclear Codes
//
//  Created by Amit Samant on 21/08/21.
//

import SwiftUI

@main
struct NuclearCodesApp: App {
    
    @StateObject var appLockVM = AppLockViewModel()
    @StateObject var profileStore = ProfileStore()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(profileStore)
                .environmentObject(appLockVM)
        }
    }
}

