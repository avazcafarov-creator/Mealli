//
//  SocialButton.swift
//  Mealli
//
//  Created by Avaz Cafarov on 11.11.26.
//

import UIKit

final class SocialButton: UIButton {
    enum Provider {
        case apple, google
        
        var title: String {
            switch self {
            case .apple: return "Apple ilə davam et"
            case .google: return "Google ilə davam et"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .apple: return UIImage(systemName: "apple.logo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold))
            case .google: return UIImage(named: "google_logo")
            }
        }
        
        var background: UIColor {
            switch self {
            case .apple: return .ink
            case .google: return .surface
            }
        }
        
        var foreground: UIColor {
            switch self {
            case .apple: return .white
            case .google: return .ink
            }
        }
        
        var strokeColor: UIColor? {
            switch self {
            case .apple: return nil
            case .google: return .ink3
            }
        }
    }
    
    private let provider: Provider
    
    init(provider: Provider) {
        self.provider = provider
        super.init(frame: .zero)
        configureUI(provider)
    }
    
    private func configureUI(_ provider: Provider) {
        var config = UIButton.Configuration.plain()
        config.title = provider.title
        config.image = provider.image
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.baseForegroundColor = provider.foreground
        config.background.backgroundColor = provider.background
        config.cornerStyle = .capsule
        config.background.strokeColor = provider.strokeColor
        config.background.strokeWidth = 1
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = AppTextStyle.h3.font
            return outgoing
        }
        self.configuration = config
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
