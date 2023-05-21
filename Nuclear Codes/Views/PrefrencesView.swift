//
//  PrefrencesView.swift
//  PrefrencesView
//
//  Created by Amit Samant on 23/08/21.
//

import SwiftUI

struct PrefrencesView: View {
    
    @EnvironmentObject var appLockVM: AppLockViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $appLockVM.isAppLockEnabled, label: {
                    Text("App Lock")
                })
                .onChange(of: appLockVM.isAppLockEnabled, perform: { value in
                    appLockVM.appLockStateChange(appLockState: value)
                })
            }
            .navigationTitle("Prefrences")
        }
    }
}

struct PrefrencesView_Previews: PreviewProvider {
    static var previews: some View {
        PrefrencesView()
    }
}
