//
//  OnboardingFlow.swift
//  Mealli
//
//  Created by Avaz Cafarov on 04.11.26.
//

import Foundation
import UIKit

enum OnboardingFlow {
    static let screens: [() -> UIViewController] = [
        { OnboardingNameController() },
        { OnboardingAgeController() }
    ]
}
