//
//  SectionIndexedListView.swift
//  SectionIndexedListView
//
//  Created by Amit Samant on 23/08/21.
//

import SwiftUI

struct SecretSectionIndexedListView: View {
    
    @EnvironmentObject var profileStore: ProfileStore
    let groupedItems: [Dictionary<String, [SecretItem]>.Element]
    
    var sectionIndexedList: some View {
        ForEach(groupedItems, id: \.key) { categoryName, secretItems in
            Section {
                ForEach(secretItems, id: \.id) { secretItem in
                    NavigationLink {
                        SecretDetailView(secretItem: secretItem)
                    } label: {
                        SecretRow(secretItem: secretItem)
                    }
                }
            } header: {
                Text(categoryName)
            }
        }
    }
        
    var body: some View {
        ScrollViewReader { proxy in
            List {
                if !groupedItems.isEmpty,
                    let selectedProfile = profileStore.selectedProfile {
                    Section {
                        NavigationLink {
                            ProfilesList()
                        } label: {
                            ProfileRow(
                                isSelected: false,
                                profile: selectedProfile
                            )
                        }
                    } footer: {
                        Text("Above is the current profile used to populate nuclear code, tap to change or add profile.")
                    }
                }
                sectionIndexedList
            }
            .listStyle(InsetGroupedListStyle())
            .overlay(sectionIndexTitles(proxy: proxy))
        }
    }
    
    func sectionIndexTitles(proxy: ScrollViewProxy) -> some View {
        SectionIndexedDragListView(
            proxy: proxy,
            titles: groupedItems.map(\.key)
        ).frame(
            maxWidth: .infinity,
            alignment: .trailing
        )
    }
}

struct SectionIndexedListView_Previews: PreviewProvider {
    static var previews: some View {
        SecretSectionIndexedListView(groupedItems: [])
    }
}
