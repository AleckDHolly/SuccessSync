//
//  ContentView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("firstTime") var isFirstTime: Bool = true
    @Query private var assets: [Asset]
    @Query private var habits: [Habit]
    @Query private var goals: [Goal]
    @Query private var allJournals: [Journal]
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            HabitsView()
                .tabItem {
                    Label("Habits", systemImage: "calendar")
                }
            
            GoalsView()
                .tabItem {
                    Label("Goals", systemImage: "list.bullet.clipboard")
                }
            
            JournalFolders()
                .tabItem {
                    Label("Journal", systemImage: "book.pages.fill")
                }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            if !isFirstTime && (!assets.isEmpty || !habits.isEmpty || !goals.isEmpty || !allJournals.isEmpty) {
                AppOpenAdManager.shared.showAdIfAvailable()
            }
        }
        .fullScreenCover(isPresented: $isFirstTime) {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
