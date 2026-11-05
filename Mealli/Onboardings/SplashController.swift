//
//  SplashController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 04.11.26.
//

import UIKit

class SplashController: UIViewController {
    private lazy var logoView: UIImageView = {
        let lV = UIImageView()
        lV.image = UIImage(named: "mealli logo")
        lV.layer.cornerRadius = 44
        lV.contentMode = .scaleAspectFill
        lV.clipsToBounds = true
        lV.heightAnchor.constraint(equalToConstant: 88).isActive = true
        lV.widthAnchor.constraint(equalToConstant: 164).isActive = true
        lV.translatesAutoresizingMaskIntoConstraints = false
        return lV
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let dL = UILabel()
        dL.text = "Büdcəni ver, nə alacağını \nvə nə bişirəcəyini deyək."
        dL.numberOfLines = 2
        dL.font = .systemFont(ofSize: 20, weight: .bold)
        dL.lineBreakMode = .byWordWrapping
        dL.textAlignment = .center
        dL.textColor = .surface
        dL.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dL.translatesAutoresizingMaskIntoConstraints = false
        return dL
    }()
    
    private lazy var stackViewLogoAndDescription: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [logoView, descriptionLabel])
        sV.axis = .vertical
        sV.alignment = .center
        sV.spacing = 12
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var startButton: UIButton = {
        let sB = UIButton(type: .system)
        sB.setTitle("Başla", for: .normal)
        sB.titleLabel?.applyStyle(.h3)
        sB.setTitleColor(UIColor(named: "ink"), for: .normal)
        sB.backgroundColor = .brandLime
        sB.heightAnchor.constraint(equalToConstant: 56).isActive = true
        sB.layer.cornerRadius = 28
        sB.translatesAutoresizingMaskIntoConstraints = false
        return sB
    }()
    
    private lazy var alreadyLoggedInButton: UIButton = {
        let aLL = UIButton(type: .system)
        let style = AppTextStyle.h3
        let title = NSAttributedString(
            string: "Artıq hesabım var",
            attributes: [
                .font: style.font,
                .foregroundColor: UIColor.surface,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.surface
            ]
        )
        aLL.setAttributedTitle(title, for: .normal)
        aLL.titleLabel?.textAlignment = .center
        aLL.translatesAutoresizingMaskIntoConstraints = false
        
        aLL.addTarget(self, action: #selector(didTapAlreadyLoggedInLabel), for: .touchUpInside)
        return aLL
    }()
    
    private lazy var loginRegisterStackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [startButton, alreadyLoggedInButton])
        sV.axis = .vertical
        sV.alignment = .fill
        sV.spacing = 16
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var splashBackgroundView: UIImageView = {
        let iV = UIImageView(image: UIImage(named: "bg-splash"))
        iV.contentMode = .scaleAspectFill
        iV.clipsToBounds = true
        iV.translatesAutoresizingMaskIntoConstraints = false
        return iV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func configureUI() {
        view.backgroundColor = .brandDeep
    }
    
    private func configureConstraints() {
        view.addSubview(splashBackgroundView)
        view.addSubview(stackViewLogoAndDescription)
        view.addSubview(loginRegisterStackView)
        
        NSLayoutConstraint.activate([
            splashBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            splashBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            stackViewLogoAndDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewLogoAndDescription.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loginRegisterStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginRegisterStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginRegisterStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    @objc private func didTapAlreadyLoggedInLabel() {
        let loginController = LoginController()
        navigationController?.pushViewController(loginController, animated: true)
    }
}
