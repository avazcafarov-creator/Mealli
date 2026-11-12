//
//  OnboardingNameController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import UIKit

class OnboardingNameController: BaseOnboardingController, OnboardingStep {
    var stepTitle: String { "Adın" }
    
    private lazy var continueButton: AppButton = {
        let cB = AppButton(style: .primary, title: "Davam et")
        cB.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return cB
    }()
    
    private lazy var haveAccountButton: AppButton = {
        let button = AppButton(style: .tertiary, title: "Artıq hesabım var")
        button.addTarget(self, action: #selector(haveAccountTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [continueButton, haveAccountButton])
        sV.axis = .vertical
        sV.spacing = 4
        sV.alignment = .fill
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var greetingText: UILabel = {
        let gT = UILabel()
        gT.text = "Salam! Adın nədir?"
        gT.applyStyle(.h2)
        gT.numberOfLines = 1
        gT.textAlignment = .center
        gT.translatesAutoresizingMaskIntoConstraints = false
        return gT
    }()
    
    private lazy var greetingSubtitleText: UILabel = {
        let gST = UILabel()
        gST.text = "Sənə necə müraciət edək?"
        gST.applyStyle(.body)
        gST.textColor = .ink2
        gST.numberOfLines = 1
        gST.textAlignment = .center
        gST.translatesAutoresizingMaskIntoConstraints = false
        return gST
    }()
    
    private lazy var greetingStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [greetingText, greetingSubtitleText])
        sV.axis = .vertical
        sV.spacing = 4
        sV.alignment = .center
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var textField: AppTextField = {
        let tF = AppTextField(type: .name)
        tF.placeholder = "Adın"
        tF.returnKeyType = .done
        tF.delegate = self
        return tF
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        continueButton.isEnabled = false
        textField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
    }
    
    private func configureConstraints() {
        view.addSubview(bottomStackView)
        view.addSubview(greetingStackView)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            greetingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalTo: greetingStackView.bottomAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: greetingStackView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: greetingStackView.trailingAnchor),
        ])
    }
    
    @objc private func continueTapped() {
        pushNext()
    }
    
    @objc private func nameChanged() {
        let name = textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        continueButton.isEnabled = !name.isEmpty
    }
    
    @objc private func haveAccountTapped() {
        let presenter = presentingViewController as? UINavigationController
        dismiss(animated: true) {
            presenter?.pushViewController(LoginController(), animated: true)
        }
    }
}

extension OnboardingNameController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if continueButton.isEnabled { continueTapped() }
        return true
    }
}
