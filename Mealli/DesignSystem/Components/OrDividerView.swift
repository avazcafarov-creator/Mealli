//
//  OrDividerView.swift
//  Mealli
//
//  Created by Avaz Cafarov on 11.11.26.
//

import UIKit

final class OrDividerView: UIView {
    private lazy var dividerText: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.applyStyle(.caption)
        text.textColor = .ink2
        text.setContentHuggingPriority(.required, for: .horizontal)
        text.setContentCompressionResistancePriority(.required, for: .horizontal)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var dividerStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [leftLine, dividerText, rightLine])
        sV.axis = .horizontal
        sV.spacing = 8
        sV.alignment = .center
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private func makeLine() -> UIView {
        let dv = UIView()
        dv.backgroundColor = .ink3
        dv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dv.translatesAutoresizingMaskIntoConstraints = false
        return dv
    }
    
    private lazy var leftLine = makeLine()
    private lazy var rightLine = makeLine()
    
    init(title: String = "və ya") {
        super.init(frame: .zero)
        dividerText.text = title
        
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        addSubview(dividerStackView)
        
        NSLayoutConstraint.activate([
            dividerStackView.topAnchor.constraint(equalTo: topAnchor),
            dividerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rightLine.widthAnchor.constraint(equalTo: leftLine.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
