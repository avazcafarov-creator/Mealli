//
//  GradientView.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import UIKit

final class GradientView: UIView {
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    
    private var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    private func setupGradient() {
        let startColor = UIColor(named: "brand_lime_soft")
        let endColor = UIColor(named: "surface")
        
        gradientLayer.colors = [startColor!.cgColor, endColor!.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradientLayer.locations = [0, 0.62]
    }
}
