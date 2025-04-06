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
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("Habits", systemImage: "calendar") {
                HabitsView()
            }
            
            Tab("Ideas", systemImage: "list.bullet.clipboard") {
                IdeasView()
            }
            
            Tab("Finance", systemImage: "creditcard.fill") {
                FinanceView()
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
