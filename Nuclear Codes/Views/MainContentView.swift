//
//  ContentView.swift
//  Shared
//
//  Created by Amit Samant on 16/06/21.
//

import SwiftUI

struct MainContentView: View {
    
    @EnvironmentObject var profileStore: ProfileStore
    @EnvironmentObject var appLockVM: AppLockViewModel
    @StateObject var viewModel = ContentViewModel()
    @State var pushProfileList = false
    @State var isShowingAddProfile = false
    @State var isShowingPrefrences = false
    
    @ViewBuilder
    var list: some View {
        SecretListView()
        .environmentObject(viewModel)
        .refreshable {
            await loadAsyncData(loadSource: .pullToRefresh)
        }
    }
    
    @ViewBuilder
    var overlay: some View {
        switch viewModel.state {
            case .initial, .loading:
                if profileStore.selectedProfile == nil {
                    AddProfileDialogView {
                        isShowingAddProfile = true
                    }
                } else {
                    LoaderView()
                }
                
            case .error(let messages):
                RetryView(messages) {
                    loadData()
                } changeProfileAction: {
                    pushProfileList = true
                }
            case .loaded:
                if viewModel.items.isEmpty {
                    EmptyStateView {
                        loadData()
                    }
                }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                list
                    .searchable(
                        text: $viewModel.query,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: Text("Search")
                    )
                NavigationLink(
                    destination: ProfilesList(),
                    isActive: $pushProfileList
                ) { EmptyView() }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingPrefrences = true
                    } label: {
                        Label("Settings",systemImage: "gear")
                    }
                }
            }
            .overlay(overlay)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Nuclear codes")
        }
        .task {
            if profileStore.selectedProfile != nil {
                await loadAsyncData()
            } else {
                isShowingAddProfile = true
            }
        }
        .sheet(isPresented: $isShowingAddProfile) {
            ProfileForm(profile: nil) { newProfile in
                profileStore.add(newProfile)
                profileStore.selectedProfile = newProfile
            }
        }
        .sheet(isPresented: $isShowingPrefrences) {
            PrefrencesView()
                .environmentObject(appLockVM)
        }
        .onChange(of: profileStore.selectedProfile) { newProfile in
            loadData(profile: newProfile)
        }
    }
    
    func loadData(profile: Profile? = nil) {
        Task.detached(priority: .userInitiated) {
            await loadAsyncData(profile: profile)
        }
    }
    
    func loadAsyncData(profile: Profile? = nil, loadSource: ContentViewModel.LoadSource = .other) async  {
        if let profile =  profile ?? profileStore.selectedProfile {
            await viewModel.getData(forProfile: profile, loadSource: loadSource)
        } else {
            viewModel.empty()
            isShowingAddProfile = true
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
