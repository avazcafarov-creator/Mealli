//
//  SplashController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 04.11.26.
//

import UIKit

class SplashController: UIViewController {
    private lazy var logoLabel: UILabel = {
        let view = UILabel()
        view.text = "Mealli"
        view.applyStyle(.displayNumber)
        view.textColor = .brandDeep
        view.textAlignment = .center
        view.backgroundColor = .brandLime
        view.heightAnchor.constraint(equalToConstant: 56).isActive = true
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let dL = UILabel()
        dL.text = "Büdcəni ver, nə alacağını və nə bişirəcəyini deyək."
        dL.numberOfLines = 2
        dL.font = .systemFont(ofSize: 24, weight: .bold)
        dL.lineBreakMode = .byWordWrapping
        dL.textAlignment = .center
        dL.textColor = .surface
        dL.translatesAutoresizingMaskIntoConstraints = false
        return dL
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brandDeep
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        view.addSubview(logoLabel)
    }
    
    private func configureConstraints() {
        view.addSubview(logoLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: logoLabel.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 8),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}
