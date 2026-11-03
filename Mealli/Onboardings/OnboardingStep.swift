//
//  OnboardingStep.swift
//  Mealli
//
//  Created by Avaz Cafarov on 03.11.26.
//

import Foundation
import UIKit

protocol OnboardingStep: UIViewController {
    var stepIndex: Int { get }
    var stepTitle: String { get }
}
