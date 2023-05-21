//
//  AppLockView.swift
//  AppLockView
//
//  Created by Amit Samant on 23/08/21.
//

import SwiftUI

struct AppLockView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
   
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "lock.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundStyle(.secondary)
                .foregroundColor(.blue)
            
            Text("App Locked")
                .font(.title)
                .foregroundStyle(.primary)
                .foregroundColor(.blue)
            
            Button("Open") {
                appLockVM.appLockValidation()
            }
            .foregroundColor(.primary)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.red)
                
            )
            Spacer(minLength: 0)
        }.padding(.top, 50)
    }
}

struct AppLockView_Previews: PreviewProvider {
    static var previews: some View {
        AppLockView()
    }
}
