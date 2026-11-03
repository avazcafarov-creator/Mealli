//
//  UILabel+Style.swift
//  Mealli
//
//  Created by Avaz Cafarov on 30.10.26.
//

import Foundation
import UIKit

extension UILabel {
    func applyStyle(_ style: AppTextStyle) {
        font = style.font
        textColor = style.color
    }
}
