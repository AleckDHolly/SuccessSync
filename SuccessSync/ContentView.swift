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
            //            Tab("Home", systemImage: "house.fill") {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            //            }
            
            //            Tab("Habits", systemImage: "calendar") {
            HabitsView()
                .tabItem {
                    Label("Habits", systemImage: "calendar")
                }
            //            }
            
            //            Tab("Ideas", systemImage: "list.bullet.clipboard") {
            IdeasView()
                .tabItem {
                    Label("Ideas", systemImage: "list.bullet.clipboard")
                }
            //            }
            
            //            Tab("Finance", systemImage: "creditcard.fill") {
            FinanceView()
                .tabItem {
                    Label("Finance", systemImage: "creditcard.fill")
                }
            //            }
            
            //            Tab("Settings", systemImage: "gear") {
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            //            }
        }
    }
}

#Preview {
    ContentView()
}
