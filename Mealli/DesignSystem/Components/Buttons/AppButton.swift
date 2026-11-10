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
    
    private func configureUI(title: UIButton.Configuration) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .capsule
        config.baseBackgroundColor = style.background
        config.baseForegroundColor = style.foreground
        
        self.configuration = config
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
