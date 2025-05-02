//
//  SingleOnboarding.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-13.
//

import SwiftUI
import Lottie

struct SingleOnboarding: View {
    let onboarding: Onboarding
    
    var body: some View {
        VStack {
            Text(onboarding.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(onboarding.subtitle)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let lottie = onboarding.lottie {
                LottieView(animation: .named(lottie))
                    .looping()
                    .frame(width: 300, height: 300)
            }
        }
        .padding()
    }
}

#Preview {
    SingleOnboarding(onboarding: .init(title: "Welcome to SuccessSync", subtitle: "Add your life dreams pictures to motivate you everyday.", lottie: "1"),)
}
