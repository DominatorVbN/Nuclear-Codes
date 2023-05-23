//
//  ContentView.swift
//  ContentView
//
//  Created by Amit Samant on 22/08/21.
//

import SwiftUI

struct SecretListView: View {
    
    @EnvironmentObject var profileStore: ProfileStore
    @EnvironmentObject var viewModel: ContentViewModel
    @Environment(\.isSearching) var isSearching
    @State var isShowingProfiles = false
    
    var filteredListView: some View {
        List(viewModel.items) { secretItem in
            NavigationLink {
                SecretDetailView(secretItem: secretItem)
            } label: {
                SecretRow(secretItem: secretItem)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .frame(maxWidth: .infinity, alignment: .trailing)
        .overlay {
            if isSearching {
                Group {
                    if viewModel.filtered.isEmpty {
                        VStack(spacing: 16) {
                            Text("No Results")
                                .font(.title)
                            Text("for \"\(viewModel.query)\"")
                        }
                        .foregroundStyle(.secondary)
                    } else {
                        List(viewModel.filtered) { secretItem in
                            NavigationLink {
                                SecretDetailView(secretItem: secretItem)
                            } label: {
                                SecretRow(secretItem: secretItem)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thickMaterial)
            }
            
        }
    }
    
    var body: some View {
        SecretSectionIndexedListView(groupedItems: viewModel.groupedItems)
            .overlay {
                if isSearching && !viewModel.query.isEmpty {
                    filteredListView
                }
            }
    }
    
}

struct SecretListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SecretListView()
        }
    }
}

