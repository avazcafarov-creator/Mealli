//
//  OnboardingNavigationView.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import UIKit

final class OnboardingNavigationView: UIView {
    private let segmentsStack = UIStackView()
    private var segments: [UIView] = []
    var onBack: (() -> Void)?
    private let totalSteps = 15
    
    private lazy var backButton: UIButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        button.tintColor = .brandDeep
        button.backgroundColor = .brandLime
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let tL = UILabel()
        tL.applyStyle(.h3)
        tL.textAlignment = .center
        tL.translatesAutoresizingMaskIntoConstraints = false
        return tL
    }()
    
    private lazy var countLabel: UILabel = {
        let cL = UILabel()
        cL.applyStyle(.caption)
        cL.textAlignment = .right
        cL.translatesAutoresizingMaskIntoConstraints = false
        return cL
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        configureSegments()
        layoutUI()
    }
    
    @objc private func backTapped() {
        onBack?()
    }
    
    private func configureSegments() {
        segmentsStack.axis = .horizontal
        segmentsStack.distribution = .fillEqually
        segmentsStack.spacing = 4
        segmentsStack.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<totalSteps {
            let segment = UIView()
            segment.backgroundColor = .ink3
            segment.layer.cornerRadius = 2
            segmentsStack.addArrangedSubview(segment)
            segments.append(segment)
        }
    }
    
    private func layoutUI() {
        [backButton, titleLabel, countLabel, segmentsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            segmentsStack.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 4),
            segmentsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segmentsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            segmentsStack.heightAnchor.constraint(equalToConstant: 4),
            segmentsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func update(current: Int, title: String) {
        titleLabel.text = title
        countLabel.text = "\(current)/\(totalSteps)"
        backButton.isHidden = current <= 1
        
        UIView.animate(withDuration: 0.25){
            for (index, segment) in self.segments.enumerated() {
                segment.backgroundColor = index < current ? .brandDeep : .ink3
            }
        }
    }
}
