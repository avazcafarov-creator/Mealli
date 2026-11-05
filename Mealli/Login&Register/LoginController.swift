//
//  LoginController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 05.11.26.
//

import UIKit

class LoginController: BaseOnboardingController {
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
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureConstraints() {
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
