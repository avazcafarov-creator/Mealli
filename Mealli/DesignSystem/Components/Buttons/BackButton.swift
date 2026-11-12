//
//  BackButton.swift
//  Mealli
//
//  Created by Avaz Cafarov on 12.11.26.
//

import UIKit

final class BackButton: UIButton {
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    private func configureUI() {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        tintColor = .brandDeep
        backgroundColor = .brandLime
        layer.cornerRadius = 22
        widthAnchor.constraint(equalToConstant: 44).isActive = true
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var isHighlighted: Bool {
        didSet {
            transform = isHighlighted ? CGAffineTransform(scaleX: 0.92, y: 0.92) : .identity
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
