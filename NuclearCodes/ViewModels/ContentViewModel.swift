//
//  ContentViewModel.swift
//  Doppler Manager (iOS)
//
//  Created by Amit Samant on 19/06/21.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    enum State {
        case initial
        case error(messages: [String])
        case loading
        case loaded
    }
    
    enum LoadSource {
        case pullToRefresh
        case other
    }
    
    @Published var state: State = .initial
    @Published var items: [SecretItem] = []
    @Published var groupedItems: [Dictionary<String, [SecretItem]>.Element] = []
    
    @Published var query: String = ""
    
    var filtered: [SecretItem] {
        self.items.filter { item in
            let itemPath = item.path.lowercased()
            let lowercasedQuery = query.lowercased()
            return itemPath.contains(lowercasedQuery) || lowercasedQuery.contains(itemPath)
        }
    }
    
    @MainActor func getData(forProfile profile: Profile, loadSource: LoadSource = .other) async {
        do {
            if loadSource != .pullToRefresh {
                self.state = .loading
            }
            let items = try await getItems(profile)
            self.items = items.sorted(by: { $0.path < $1.path })
            self.groupedItems = Dictionary(
                grouping: self.items,
                by: {
                    String($0.path.prefix(1))
                }).sorted(
                    by: { $0.key < $1.key }
                )
            self.state = .loaded
        } catch DopplerAPIError.failed(let messages) {
            self.state = .error(messages: messages)
            empty()
        } catch {
            print(error)
            self.state = .error(messages: [])
            empty()
        }
    }
    
    func empty() {
        self.items = []
        self.groupedItems = []
    }
    
    func getItems(_ profile: Profile) async throws -> [SecretItem] {
        guard let request = DopplerAPI.getSecret(
            username: profile.key,
            project: profile.project,
            config: profile.config
        ).getURLRequest() else {
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            return try .from(jsonObject: jsonObject)
        } catch {
            throw error
        }
    }
    
}
