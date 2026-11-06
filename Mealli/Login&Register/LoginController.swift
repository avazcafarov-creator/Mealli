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
    
    private lazy var greetingText: UILabel = {
        let gT = UILabel()
        gT.text = "Xoş gəlmisiniz!"
        gT.applyStyle(.h2)
        gT.numberOfLines = 1
        gT.textAlignment = .center
        gT.translatesAutoresizingMaskIntoConstraints = false
        return gT
    }()
    
    private lazy var greetingSubtitleText: UILabel = {
        let gST = UILabel()
        gST.text = "Hesabına daxil ol, planın səni gözləyir."
        gST.applyStyle(.body)
        gST.numberOfLines = 1
        gST.textAlignment = .center
        gST.translatesAutoresizingMaskIntoConstraints = false
        return gST
    }()
    
    private lazy var greetingStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [greetingText, greetingSubtitleText])
        sV.axis = .vertical
        sV.spacing = 8
        sV.alignment = .center
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var appleLoginButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Apple ilə davam et"
        config.image = UIImage(systemName: "apple.logo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold))
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.baseForegroundColor = .white
        config.background.backgroundColor = .ink
        config.cornerStyle = .capsule
        
        let aLB = UIButton(configuration: config)
        aLB.titleLabel?.applyStyle(.body)
        aLB.heightAnchor.constraint(equalToConstant: 52).isActive = true
        aLB.translatesAutoresizingMaskIntoConstraints = false
        return aLB
    }()
    
    private lazy var googleLoginButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Google ilə davam et"
        config.image = UIImage(named: "google_logo")
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.background.backgroundColor = .surface
        config.baseForegroundColor = .ink
        config.cornerStyle = .capsule
        
        let gLB = UIButton(configuration: config)
        gLB.titleLabel?.applyStyle(.body)
        gLB.heightAnchor.constraint(equalToConstant: 52).isActive = true
        gLB.translatesAutoresizingMaskIntoConstraints = false
        return gLB
    }()
    
    private lazy var loginStackView: UIStackView = {
       let sV = UIStackView(arrangedSubviews: [appleLoginButton, googleLoginButton])
        sV.axis = .vertical
        sV.spacing = 8
        sV.alignment = .fill
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
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
        view.addSubview(greetingStackView)
        view.addSubview(loginStackView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            greetingStackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            greetingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginStackView.topAnchor.constraint(equalTo: greetingStackView.bottomAnchor, constant: 20),
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
