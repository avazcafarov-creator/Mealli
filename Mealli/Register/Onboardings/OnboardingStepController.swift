//
//  OnboardingStepController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 12.11.26.
//

import UIKit

class OnboardingStepController: BaseOnboardingController , OnboardingStep {
    var stepTitle: String { "" }
    var headerTitle: String { "" }
    var headerSubtitle: String? { nil }
    var showsHaveAccountButton: Bool { false }
    var onboardingData: OnboardingData? {
        (navigationController as? OnboardingNavigationController)?.data
    }
    
    private(set) lazy var continueButton: AppButton = {
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
    
    private(set) lazy var headerView = ScreenHeaderView(title: headerTitle, subtitle: headerSubtitle)
    
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        haveAccountButton.isHidden = !showsHaveAccountButton
        configureConstraints()
        setupContent()
    }
    
    private func configureConstraints() {
        view.addSubview(headerView)
        view.addSubview(contentView)
        view.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            contentView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -16),
            
            bottomStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupContent() {}
    
    @objc func continueTapped() {
        pushNext()
    }
    
    @objc private func haveAccountTapped() {
        let presenter = presentingViewController as? UINavigationController
        dismiss(animated: true) {
            presenter?.pushViewController(LoginController(), animated: true)
        }
    }
    
    func handleBack() -> Bool { false }
}
