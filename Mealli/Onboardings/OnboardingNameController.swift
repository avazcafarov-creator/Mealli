//
//  OnboardingNameController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import UIKit

class OnboardingNameController: BaseOnboardingController, OnboardingStep {
    var stepTitle: String { "Adın" }
    private lazy var continueButton: UIButton = {
        let cB = UIButton(type: .system)
        cB.setTitle("Davam et", for: .normal)
        cB.titleLabel?.font = AppTextStyle.h3.font
        cB.setTitleColor(.surface, for: .normal)
        cB.backgroundColor = .ink
        cB.layer.cornerRadius = 16
        cB.translatesAutoresizingMaskIntoConstraints = false
        cB.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return cB
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        view.addSubview(continueButton)
    }
  
    private func configureConstraints() {
        NSLayoutConstraint.activate([
                   continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                   continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                   continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                   continueButton.heightAnchor.constraint(equalToConstant: 56)
               ])
    }
    
    @objc private func continueTapped() {
        pushNext()
    }
}
