//
//  AppSegmentedControl.swift
//  Mealli
//
//  Created by Avaz Cafarov on 17.11.26.
//

import UIKit

final class AppSegmentedControl: UISegmentedControl {
    init(items: [String], selectedIndex: Int = 0) {
        super.init(frame: .zero)
        for (index, item) in items.enumerated() {
            insertSegment(withTitle: item, at: index, animated: false)
        }
        selectedSegmentIndex = selectedIndex
        configureUI()
    }
    
    private func configureUI() {
        selectedSegmentTintColor = .brandLime
        backgroundColor = .surface
        setTitleTextAttributes([
            .foregroundColor: UIColor.ink2,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ], for: .normal)
        setTitleTextAttributes([
            .foregroundColor: UIColor.brandDeep,
            .font: AppTextStyle.label.font
        ], for: .selected)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
