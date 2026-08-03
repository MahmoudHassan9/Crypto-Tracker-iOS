//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 25/07/2026.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var homeViewModel: HomeViewModel = DIContainer
        .homeViewModel
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
            UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
            UITableView.appearance().backgroundColor = UIColor.clear
        }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .toolbar(.hidden)
            .environmentObject(homeViewModel)
        }
    }
}
