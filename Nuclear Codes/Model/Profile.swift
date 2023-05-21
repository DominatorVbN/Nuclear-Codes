//
//  Profile.swift
//  Doppler Manager
//
//  Created by Amit Samant on 16/06/21.
//

import Foundation

struct Profile: Codable, Identifiable, Equatable, Hashable {
        
    var name: String
    var key: String
    var project: String
    var config: String
    var id: String
    
    var isEmpty: Bool {
        id.isEmpty
    }
    
    var isValid: Bool {
        !name.isEmpty && !key.isEmpty && !project.isEmpty && !config.isEmpty
    }
    
    static var placeholder: Profile {
        Profile(name: "--", key: "--", project: "--", config: "--")
    }
    
    static var empty: Profile {
        Profile()
    }
    
    init(id: String? = nil, name: String = "", key: String = "", project: String = "", config: String = "") {
        self.name = name
        self.key = key
        self.project = project
        self.config = config
        self.id = id ?? UUID().uuidString
    }
    
    mutating func update(forProfile profile: Profile) {
        self.name = profile.name
        self.key = profile.key
        self.project = profile.project
        self.config = profile.config
    }
    
//    init?(rawValue: String) {
//        guard let data = rawValue.data(using: .utf8) else {
//            return nil
//        }
//        do {
//            self = try JSONDecoder().decode(Self.self, from: data)
//        } catch {
//            debugPrint(error)
//            return nil
//        }
//    }
//
//    var rawValue: String {
//        do {
//            let data = try JSONEncoder().encode(self)
//            return String(data: data, encoding: .utf8) ?? ""
//        } catch {
//            debugPrint(error)
//            return ""
//        }
//    }
    
}
