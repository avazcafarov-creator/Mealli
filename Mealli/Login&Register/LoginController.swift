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
        config.background.strokeColor = .ink3
        
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
    
    private lazy var dividerView: UIView = {
        let dv = UIView()
        dv.backgroundColor = .ink3
        dv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dv.translatesAutoresizingMaskIntoConstraints = false
        return dv
    }()
    
    private lazy var dividerView2: UIView = {
        let dv = UIView()
        dv.backgroundColor = .ink3
        dv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dv.translatesAutoresizingMaskIntoConstraints = false
        return dv
    }()
    
    private lazy var dividerText: UILabel = {
        let text = UILabel()
        text.text = "və ya"
        text.textAlignment = .center
        text.applyStyle(.caption)
        text.textColor = .ink2
        text.setContentHuggingPriority(.required, for: .horizontal)
        text.setContentCompressionResistancePriority(.required, for: .horizontal)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var dividerStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [dividerView, dividerText, dividerView2])
        sV.axis = .horizontal
        sV.spacing = 8
        sV.alignment = .center
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
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
    
    private lazy var forgotPasswordButton: UIButton = {
        let fPB = UIButton(type: .system)
        fPB.setTitle("Şifrəni unutmusan?", for: .normal)
        fPB.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        fPB.setTitleColor(.brandDeep, for: .normal)
        fPB.contentHorizontalAlignment = .trailing
        fPB.heightAnchor.constraint(equalToConstant: 40).isActive = true
        fPB.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var signInButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Daxil ol"
        config.baseForegroundColor = .white
        config.background.backgroundColor = .brandDeep
        config.cornerStyle = .capsule
        
        let sIB = UIButton(configuration: config)
        sIB.heightAnchor.constraint(equalToConstant: 52).isActive = true
        sIB.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var startButton: UIButton = {
        let sB = UIButton(type: .system)
        sB.setTitle("Başla", for: .normal)
        sB.titleLabel?.font = AppTextStyle.h3.font
        sB.setTitleColor(.brandDeep, for: .normal)
        sB.translatesAutoresizingMaskIntoConstraints = false
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func configureConstraints() {
        view.addSubview(backButton)
        view.addSubview(greetingStackView)
        view.addSubview(loginStackView)
        view.addSubview(dividerStackView)
        view.addSubview(formStackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            greetingStackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            greetingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginStackView.topAnchor.constraint(equalTo: greetingStackView.bottomAnchor, constant: 16),
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            
            dividerStackView.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
            dividerStackView.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            dividerStackView.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            dividerView.widthAnchor.constraint(equalTo: dividerView2.widthAnchor),
            
            formStackView.topAnchor.constraint(equalTo: dividerStackView.bottomAnchor, constant: 16),
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
        let emailOK = emailField.validate()
        let passwordOK = passwordField.validate()
        guard emailOK, passwordOK else { return }
        view.endEditing(true)
    }
    
    @objc private func startButtonTapped() {
        let onboardingNavigationController = OnboardingNavigationController(rootViewController: OnboardingNameController())
        onboardingNavigationController.modalPresentationStyle = .fullScreen
        present(onboardingNavigationController, animated: true)
    }
    
    @objc private func backButtonTapped() {
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
