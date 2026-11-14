//
//  OnboardingData.swift
//  Mealli
//
//  Created by Avaz Cafarov on 14.11.26.
//

import Foundation

final class OnboardingData {
    enum Gender { case female, male, unspecified }
    
    var name: String?
    var age: Int?
    var gender: Gender?
}


