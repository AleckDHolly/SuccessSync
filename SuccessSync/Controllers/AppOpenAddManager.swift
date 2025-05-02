//
//  AppOpenAddManager.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-05-01.
//

import Foundation
import GoogleMobileAds

//class AppOpenAdManager: NSObject, FullScreenContentDelegate {
//    var appOpenAd: AppOpenAd?
//    var isLoadingAd = false
//    var isShowingAd = false
//    var loadTime: Date?
//    let fourHoursInSeconds = TimeInterval(3600 * 4)
//    
//    static let shared = AppOpenAdManager()
//    
//    private func loadAd() async {
//        // Do not load ad if there is an unused ad or one is already loading.
//        if isLoadingAd || isAdAvailable() {
//            return
//        }
//        isLoadingAd = true
//        
//        do {
//            appOpenAd = try await AppOpenAd.load(
//                with: "ca-app-pub-4217825180009305~9295476448", request: Request())
//            appOpenAd?.fullScreenContentDelegate = self
//            loadTime = Date()
//        } catch {
//            print("App open ad failed to load with error: \(error.localizedDescription)")
//        }
//        isLoadingAd = false
//    }
//    
//    
//    private func wasLoadTimeLessThanFourHoursAgo() -> Bool {
//        guard let loadTime = loadTime else { return false }
//        // Check if ad was loaded more than four hours ago.
//        return Date().timeIntervalSince(loadTime) < fourHoursInSeconds
//    }
//    
//    private func isAdAvailable() -> Bool {
//        // Check if ad exists and can be shown.
//        return appOpenAd != nil && wasLoadTimeLessThanFourHoursAgo()
//    }
//    
//    func showAdIfAvailable() {
//        // If the app open ad is already showing, do not show the ad again.
//        guard !isShowingAd else { return }
//        
//        // If the app open ad is not available yet but is supposed to show, load
//        // a new ad.
//        if !isAdAvailable() {
//            Task {
//                await loadAd()
//            }
//            return
//        }
//        
//        if let ad = appOpenAd {
//            isShowingAd = true
//            ad.present(from: nil)
//        }
//    }
//    
//    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
//        print("App open ad will be presented.")
//    }
//    
//    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
//        appOpenAd = nil
//        isShowingAd = false
//        // Reload an ad.
//        Task {
//            await loadAd()
//        }
//    }
//    
//    func ad(
//        _ ad: FullScreenPresentingAd,
//        didFailToPresentFullScreenContentWithError error: Error
//    ) {
//        appOpenAd = nil
//        isShowingAd = false
//        // Reload an ad.
//        Task {
//            await loadAd()
//        }
//    }
//}
