//
//  ProfileForm.swift
//  Doppler Manager
//
//  Created by Amit Samant on 16/06/21.
//

import SwiftUI

struct ProfileForm: View {
    
    @Environment(\.presentationMode) var presentationMode

    let profileID: String?
    var profile: Profile?
    private var onCommitHook: (Profile) -> Void

    @State private var name: String
    @State private var key: String
    @State private var project: String
    @State private var config: String
    
    init(profile inputProfile: Profile?, onCommit: @escaping (Profile) -> Void) {
        self.profile = inputProfile
        self.onCommitHook = onCommit
        profileID = profile?.id
        _name = .init(initialValue: inputProfile?.name ?? "")
        _key = .init(initialValue: inputProfile?.key ?? "")
        _project = .init(initialValue: inputProfile?.project ?? "")
        _config = .init(initialValue: inputProfile?.config ?? "")
    }
    
    var calculatedProfile: Profile {
        Profile(id: profileID,name: name, key: key, project: project, config: config)
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Preview") {
                    if calculatedProfile.isEmpty {
                        ProfileRow(isSelected: false, profile: .placeholder)
                    } else {
                        ProfileRow(isSelected: false, profile: calculatedProfile)
                    }
                }
                Section("Fields"){
                    TextField("Name", text: $name)
                    TextField("Key", text: $key)
                    TextField("Project", text: $project)
                    TextField("Config", text: $config)
                }
                
                Section {
                    Button(action: save) {
                        Text("Save")
                    }
                    .disabled(!calculatedProfile.isValid)
                }
            }
            .navigationTitle(profile == nil ? "Add Profile" : "Edit Profile")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: save) {
                        Text("Save")
                    }
                    .disabled(!calculatedProfile.isValid)
                }
            }
        }
    }
    
    func save() {
        onCommitHook(calculatedProfile)
        presentationMode.wrappedValue.dismiss()
    }
}

//struct ProfileForm_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileForm(profile: .constant(.init()))
//    }
//}
