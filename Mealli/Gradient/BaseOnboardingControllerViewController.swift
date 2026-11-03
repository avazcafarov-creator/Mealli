//
//  BaseOnboardingControllerViewController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import UIKit

class BaseOnboardingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientBackground()
    }
    
    func setupGradientBackground() {
        let gradientView = GradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.isUserInteractionEnabled = false
        
        view.insertSubview(gradientView, at: 0)
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leftAnchor.constraint(equalTo: view.leftAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
