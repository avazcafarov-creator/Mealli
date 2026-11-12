//
//  AppButton.swift
//  Mealli
//
//  Created by Avaz Cafarov on 10.11.26.
//

import UIKit

final class AppButton: UIButton {
    enum Style {
        case primary, secondary, tertiary, destructive
        
        var background: UIColor {
            switch self {
            case .primary: return .brandDeep
            case .secondary: return .brandLimeSoft
            case .tertiary: return .clear
            case .destructive: return .dangerStrong
            }
        }
        
        var foreground: UIColor {
            switch self {
            case .primary: return .white
            case .secondary: return .brandDeep
            case .tertiary: return .brandDeep
            case .destructive: return .white
            }
        }
    }
    
    private let style: Style
    
    init(style: Style = .primary, title: String) {
        self.style = style
        super.init(frame: .zero)
        configureUI(title: title)
    }
    
    private func configureUI(title: String) {
        var config: UIButton.Configuration = style == .tertiary ? .plain() : .filled()
        var attributed = AttributedString(title)
        if style == .tertiary {
            attributed.underlineStyle = .single
        }
        config.attributedTitle = attributed
        config.cornerStyle = .capsule
        config.baseBackgroundColor = style.background
        config.baseForegroundColor = style.foreground
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = AppTextStyle.h3.font
            return outgoing
        }
        
        self.configuration = config
        
        configurationUpdateHandler = { [weak self] button in
            guard let self, var config = button.configuration
            else { return }
            if !button.isEnabled {
                config.baseBackgroundColor = self.style == .tertiary ? .clear : .ink3
                config.baseForegroundColor = .ink2
            } else {
                config.baseBackgroundColor = self.style.background
                config.baseForegroundColor = self.style.foreground
            }
            button.configuration = config
            button.transform = button.isHighlighted ? CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
