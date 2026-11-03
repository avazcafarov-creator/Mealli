//
//  OnboardingNameController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import UIKit

class OnboardingNameController: BaseOnboardingController, OnboardingStep {
    var stepIndex: Int { 1 }
    var stepTitle: String { "Adın" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = OnboardingNavigationView()
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        header.update(current: 5, title: "Adın")
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
