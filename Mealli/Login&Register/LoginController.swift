//
//  LoginController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 05.11.26.
//

import UIKit

class LoginController: BaseOnboardingController {
    private lazy var backButton: BackButton = {
        let button = BackButton()
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()

    private lazy var emailField: AppInputField = {
        let field = AppInputField(title: "Email", type: .email)
        field.textField.placeholder = "ad@nümunə.az"
        field.textField.returnKeyType = .next
        field.textField.delegate = self
        field.validator = Validator.isValidEmail
        field.errorMessage = "Email düzgün yazılmayıb. Məsələn: ad@nümunə.az"
        return field
    }()
    
    private lazy var passwordField: AppInputField = {
        let field = AppInputField(title: "Şifrə", type: .password)
        field.textField.placeholder = "********"
        field.textField.returnKeyType = .done
        field.textField.delegate = self
        field.validator = Validator.isValidPassword
        field.errorMessage = "Şifrə ən azı 8 simvol olmalı, hərf və rəqəm daxil etməlidir."
        return field
    }()
    
    private lazy var forgotPasswordButton: AppButton = {
        let fPB = AppButton(style: .link, title: "Şifrəni unutmusan?")
        fPB.contentHorizontalAlignment = .trailing
        return fPB
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [passwordField, forgotPasswordButton])
        sV.axis = .vertical
        sV.spacing = 6
        sV.alignment = .fill
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var formStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [emailField, passwordStackView])
        sV.axis = .vertical
        sV.spacing = 14
        sV.alignment = .fill
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var signInButton: AppButton = {
        let sIB = AppButton(style: .primary, title: "Daxil ol")
        sIB.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return sIB
    }()
    
    private lazy var noAccountText: UILabel = {
        let nAT = UILabel()
        nAT.text = "Hesabın yoxdur?"
        nAT.applyStyle(.body)
        nAT.textColor = .ink2
        nAT.translatesAutoresizingMaskIntoConstraints = false
        return nAT
    }()
    
    private lazy var startButton: AppButton = {
        let sB = AppButton(style: .link, title: "Başla")
        sB.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return sB
    }()
    
    private lazy var noAccountStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [noAccountText, startButton])
        sV.axis = .horizontal
        sV.spacing = 4
        sV.alignment = .center
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [signInButton, noAccountStackView])
        sV.axis = .vertical
        sV.spacing = 4
        sV.alignment = .center
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var loginStackView: UIStackView = {
       let sV = UIStackView(arrangedSubviews: [appleLoginButton, googleLoginButton])
        sV.axis = .vertical
        sV.spacing = 8
        sV.alignment = .fill
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private let dividerView = OrDividerView()
    private let appleLoginButton = SocialButton(provider: .apple)
    private let googleLoginButton = SocialButton(provider: .google)
    
    private let headerView = ScreenHeaderView(
        title: "Xoş gəlmisiniz!",
        subtitle: "Hesabına daxil ol, planın səni gözləyir."
    )

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
        view.addSubview(headerView)
        view.addSubview(loginStackView)
        view.addSubview(dividerView)
        view.addSubview(formStackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            headerView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            
            loginStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            
            dividerView.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
            dividerView.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            
            formStackView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            formStackView.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            formStackView.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            
            bottomStackView.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            signInButton.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor),
            noAccountStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func signInTapped() {
        view.endEditing(true)
        let emailOK = emailField.validate()
        let passwordOK = passwordField.validate()
        guard emailOK, passwordOK else { return }
    }
    
    @objc private func startButtonTapped() {
        let onboardingNavigationController = OnboardingNavigationController(rootViewController: OnboardingNameController())
        onboardingNavigationController.modalPresentationStyle = .fullScreen
        present(onboardingNavigationController, animated: true)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField.textField {
            passwordField.textField.becomeFirstResponder()
        } else {
            signInTapped()
        }
        return true
    }
}
