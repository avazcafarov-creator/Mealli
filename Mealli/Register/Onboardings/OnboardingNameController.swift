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
        
    }
    
    private func configureConstraints() {
        view.addSubview(continueButton)
        view.addSubview(greetingStackView)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 56),
            
            greetingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalTo: greetingStackView.bottomAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor),
        ])
    }
    
    @objc private func continueTapped() {
        pushNext()
    }
}

extension OnboardingNameController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
