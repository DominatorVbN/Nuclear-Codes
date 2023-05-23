//
//  ProfilesList.swift
//  Doppler Manager
//
//  Created by Amit Samant on 16/06/21.
//

import SwiftUI

extension Int: Identifiable {
    public var id: Int {
        self
    }
}

struct ProfilesList: View {

    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var profileStore: ProfileStore
    
    @State var selectedId: String?
    @State var showEditProfile = false
    @State var toEditProfile: Profile?
    @State var showAddProfile = false

    var list: some View {
        List(
            profileStore.profiles,
            selection: $profileStore.selectedProfile
        ) { profile in
            Button  {
                profileStore.selectedProfile = profile
                presentationMode.wrappedValue.dismiss()
            } label: {
                ProfileRow(
                    isSelected: profile.id == profileStore.selectedProfile?.id,
                    profile: profile
                )
            }
            .swipeActions(edge: .leading) {
                Button {
                    toEditProfile = profile
                } label: {
                    Label("Edit", systemImage: "square.and.pencil")
                }
                .tint(.teal)
            }
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    profileStore.delete(profile)
                    profileStore.save()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            .buttonStyle(.plain)
            .tag(profile.id)
        }
        .listStyle(.automatic)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button ("Add") {
                    showAddProfile = true
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Profiles")

    }

    var body: some View {
        list
            .sheet(item: $toEditProfile) { toEditProfile in
                ProfileForm(
                    profile: toEditProfile,
                    onCommit: updateStore(forUpdatedProfile:)
                ).environmentObject(profileStore)
            }
            .sheet(isPresented: $showAddProfile) {
                ProfileForm(profile: nil) { editedProfile in
                    profileStore.profiles.insert(editedProfile, at: 0)
                }
                .environmentObject(profileStore)
            }
            .onAppear {
                if profileStore.profiles.isEmpty {
                    showAddProfile = true
                }
            }
    }
    
    func updateStore(forUpdatedProfile updatedProfile: Profile) {
        guard let index = profileStore.profiles.firstIndex(where: {$0.id == updatedProfile.id}) else {
            profileStore.add(updatedProfile)
            return
        }
        profileStore.profiles[index] = updatedProfile
        profileStore.save()
    }
}

struct ProfilesList_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesList()
    }
}
