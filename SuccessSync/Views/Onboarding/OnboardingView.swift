//
//  OnboardingView.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-13.
//

import SwiftUI
import Photos

struct OnboardingView: View {
    let onboardings = Onboarding.allCases
    @Environment(\.dismiss) var dismiss
    @AppStorage("firstTime") var isFirstTime: Bool = true
    let photos = PHPhotoLibrary.authorizationStatus()
    
    var body: some View {
        TabView {
            ForEach(onboardings) { onboarding in
                VStack {
                    Spacer()
                    
                    SingleOnboarding(onboarding: onboarding)
                    
                    Spacer()
                    
                    if onboarding == onboardings.last! {
                        Button {
                            isFirstTime = false
                            if photos == .notDetermined {
                                PHPhotoLibrary.requestAuthorization { status in
                                }
                            }
                            dismiss()
                        } label: {
                            Text("Start")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .cornerRadius(10)
                                .padding()
                            
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    OnboardingView()
}
