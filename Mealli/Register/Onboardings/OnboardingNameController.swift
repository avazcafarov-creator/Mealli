//
//  OnboardingNameController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import UIKit

class OnboardingNameController: OnboardingStepController {
    override var stepTitle: String { "Ad" }
    override var headerTitle: String { "Salam! Adın nədir?" }
    override var headerSubtitle: String? { "Sənə necə müraciət edim?" }
    override var showsHaveAccountButton: Bool { true }
    
    private lazy var textField: AppTextField = {
        let tF = AppTextField(type: .name)
        tF.placeholder = "Adın"
        tF.returnKeyType = .done
        tF.delegate = self
        return tF
    }()
    
    override func setupContent() {
        setupTextField()
        continueButton.isEnabled = false
        textField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
    }
    
    private func setupTextField() {
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    @objc private func nameChanged() {
        let name = textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        continueButton.isEnabled = !name.isEmpty
    }
    
    override func continueTapped() {
        onboardingData?.name = textField.text?.trimmingCharacters(in: .whitespaces)
        super.continueTapped()
    }
}

extension OnboardingNameController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if continueButton.isEnabled { continueTapped() }
        return true
    }
}
