//
//  SuccessSyncApp.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-01.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        print("✅ App did finish launching")
        MobileAds.shared.start(completionHandler: nil)
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = [ "45edf01593b79b85749e0ac06fc65041" ]
        
        return true
    }
}

@main
struct SuccessSyncApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    AppOpenAdManager.shared.showAdIfAvailable()
                }
        }
        .modelContainer(for: [Asset.self, Habit.self, Goal.self, Journal.self, JournalFolder.self])
    }
}


