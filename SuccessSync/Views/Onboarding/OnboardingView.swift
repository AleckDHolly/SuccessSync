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
    @Environment(\.horizontalSizeClass) var sizeClass
    
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
                            dismiss()
                        } label: {
                            Text("Start")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: sizeClass == .compact ? .infinity : 400)
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
        .background(Color("bgColor"))
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    OnboardingView()
}
