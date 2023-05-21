//
//  ContentView.swift
//  ContentView
//
//  Created by Amit Samant on 23/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appLockVM: AppLockViewModel
    @Environment(\.scenePhase) var scenePhase
    
    @State var blurRadius: CGFloat = 0


    @State var showBlur: Bool = false
    var body: some View {
        Group {
            // Show HomeView app lock is not enabled or app is in unlocked state
            if !appLockVM.isAppLockEnabled || appLockVM.isAppUnLocked {
                MainContentView()
                    .overlay {
                        if showBlur {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
                                .background(.ultraThinMaterial)
                                .edgesIgnoringSafeArea(.all)
                        }
                    }
                    .onChange(of: scenePhase, perform: { value in
                        switch value {
                            case .active :
                                showBlur = false
                            case .background:
                                appLockVM.isAppUnLocked = false
                            case .inactive:
                                showBlur = true
                            @unknown default:
                                print("unknown")
                        }
                    })
                    .environmentObject(appLockVM)
            } else {
                AppLockView()
            }
        }
        .onAppear {
            // if 'isAppLockEnabled' value true, then immediately do the app lock validation
            if appLockVM.isAppLockEnabled {
                appLockVM.appLockValidation()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
