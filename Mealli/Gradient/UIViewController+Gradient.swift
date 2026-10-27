//
//  UIViewController+Gradient.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import Foundation
import UIKit

extension UIViewController {
    func addGradientBackground() {
        guard !view.subviews.contains(where: {
            $0 is GradientView
        }) else {
            return
        }
        
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
