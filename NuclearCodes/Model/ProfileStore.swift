//
//  ProfileStore.swift
//  Doppler Manager
//
//  Created by Amit Samant on 16/06/21.
//

import Foundation
import SwiftUI
import Combine
import KeychainStored
struct Model: Codable {
    var profiles: [Profile]
    var selectedProfile: Profile?
}

class ProfileStore: ObservableObject {
    
    @KeychainStored(service: "amitsamant.in.Nuclear-Codes") var persistedSecureData: Data?
    @Published var profiles: [Profile] = []
    @Published var selectedProfile: Profile?
    var cancellable: AnyCancellable?
    init() {
        if let data = persistedSecureData {
            let model = try? JSONDecoder().decode(Model.self, from: data)
            profiles = model?.profiles ?? []
            selectedProfile = model?.selectedProfile
        }
        purgeInvalid()
        cancellable = $selectedProfile.sink { _ in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.save()
            }
        }
    }
    
    func delete(_ profile: Profile) {
        guard let index = profiles.firstIndex(of: profile) else {
            return
        }
        profiles.remove(at: index)
        if selectedProfile == profile {
            self.selectedProfile = nil
        }
        save()
    }
    
    func add(_ profile: Profile) {
        profiles.insert(profile, at: 0)
        save()
    }
    
    func purgeInvalid() {
        profiles = profiles.filter {
            $0.isValid
        }
        if let selectedProfile = selectedProfile,
           !profiles.contains(selectedProfile) {
            self.selectedProfile = nil
        }
        save()
    }
    
    
    
    func save() {
        do {
            let data = try JSONEncoder().encode(Model(profiles: profiles, selectedProfile: selectedProfile))
            self.persistedSecureData = data
        } catch {
            debugPrint(error)
        }
    }
    
    
}
