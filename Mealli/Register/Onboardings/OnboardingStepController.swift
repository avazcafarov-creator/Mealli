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
    
    private(set) lazy var headerView = ScreenHeaderView(title: headerTitle, subtitle: headerSubtitle)
    
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        haveAccountButton.isHidden = !showsHaveAccountButton
        configureConstraints()
    }
    
    private func configureConstraints() {
        view.addSubview(headerView)
        view.addSubview(contentView)
        view.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            contentView.leadingAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>)
        ])
    }
    
    @objc func continueTapped() {
        pushNext()
    }
    
    @objc private func haveAccountTapped() {
        let presenter = presentingViewController as? UINavigationController
        dismiss(animated: true) {
            presenter?.pushViewController(LoginController(), animated: true)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
