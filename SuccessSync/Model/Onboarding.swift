//
//  Onboarding.swift
//  SuccessSync
//
//  Created by Aleck David Holly on 2025-04-13.
//

import Foundation

struct Onboarding: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let subtitle: String
    let lottie: String?
    
    static let allCases: [Onboarding] = [
        .init(title: "Welcome to SuccessSync", subtitle: "Add your life dreams and pictures to motivate you everyday.", lottie: "1"),
        .init(title: "Habits", subtitle: "Add the everyday habits to help you improve your life.", lottie: "2"),
        .init(title: "Goals", subtitle: "Add your goals and why you want to achieve them.", lottie: "3"),
        .init(title: "Get Started", subtitle: "Start your journey now.", lottie: nil),
    ]
}
