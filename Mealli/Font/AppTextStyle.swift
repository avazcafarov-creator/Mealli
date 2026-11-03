//
//  AppTextStyle.swift
//  Mealli
//
//  Created by Avaz Cafarov on 30.10.26.
//

import Foundation
import UIKit

enum AppTextStyle {
    case displayNumber
    case h1
    case h2
    case h3
    case body
    case secondary
    case caption
    case listNumber
    
    var font: UIFont {
        switch self {
        case .displayNumber:
            return .systemFont(ofSize: 48, weight: .bold)
        case .h1:
            return .systemFont(ofSize: 28, weight: .bold)
        case .h2:
            return .systemFont(ofSize: 24, weight: .semibold)
        case .h3:
            return .systemFont(ofSize: 16, weight: .semibold)
        case .body:
            return .systemFont(ofSize: 16, weight: .regular)
        case .secondary:
            return .systemFont(ofSize: 14, weight: .regular)
        case .caption:
            return .systemFont(ofSize: 12, weight: .regular)
        case .listNumber:
            return .systemFont(ofSize: 16, weight: .semibold)
        }
    }
    
    var color: UIColor {
        switch self {
        case .secondary, .caption:
            return .ink2
        default:
            return .ink
        }
    }
    
    private func roundedFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        
        guard let descriptor = font.fontDescriptor.withDesign(.rounded) else {
            return font
        }
        return UIFont(descriptor: descriptor, size: size)
    }
}



