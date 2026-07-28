//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 25/07/2026.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
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
