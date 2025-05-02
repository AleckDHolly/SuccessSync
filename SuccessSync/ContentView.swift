//
//  ContentView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI

struct ContentView: View {
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
            
            AllJournals()
                .tabItem {
                    Label("Journal", systemImage: "book.pages.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
