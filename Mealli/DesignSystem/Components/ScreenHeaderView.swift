//
//  ScreenHeaderView.swift
//  Mealli
//
//  Created by Avaz Cafarov on 12.11.26.
//

import UIKit

final class ScreenHeaderView: UIView {
    private lazy var titleLabel: UILabel = {
        let gT = UILabel()
        gT.applyStyle(.h2)
        gT.numberOfLines = 0
        gT.textAlignment = .center
        gT.translatesAutoresizingMaskIntoConstraints = false
        return gT
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let gST = UILabel()
        gST.applyStyle(.body)
        gST.textColor = .ink2
        gST.numberOfLines = 0
        gST.textAlignment = .center
        gST.translatesAutoresizingMaskIntoConstraints = false
        return gST
    }()
    
    private lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        sV.axis = .vertical
        sV.spacing = 8
        sV.alignment = .center
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    init(title: String, subtitle: String? = nil) {
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = subtitle == nil
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
