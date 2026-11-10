//
//  AppInputField.swift
//  Mealli
//
//  Created by Avaz Cafarov on 10.11.26.
//

import UIKit

final class AppInputField: UIView {
    let textField: AppTextField
    private let titleLabel = UILabel()
    private let errorLabel = UILabel()
    
    private lazy var errorView: UIStackView = {
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let icon = UIImageView(image: UIImage(systemName: "exclamationmark.circle", withConfiguration: config))
        icon.tintColor = .dangerStrong
        icon.setContentHuggingPriority(.required, for: .horizontal)
        
        errorLabel.applyStyle(.secondary)
        errorLabel.textColor = .dangerStrong
        errorLabel.numberOfLines = 0
        
        let sV = UIStackView(arrangedSubviews: [icon, errorLabel])
        sV.axis = .horizontal
        sV.spacing = 6
        sV.alignment = .center
        sV.isHidden = true
        return sV
    }()
    
    private lazy var stackView: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [titleLabel, textField, errorView])
        sV.axis = .vertical
        sV.spacing = 6
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    var validator: ((String) -> Bool)?
    var errorMessage: String = ""
    
    init(title: String, type: AppTextField.InputType = .name) {
        self.textField = AppTextField(type: type)
        super.init(frame: .zero)
        titleLabel.text = title
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .ink
        
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var text: String { textField.text ?? "" }
    
    @discardableResult
    func validate() -> Bool {
        let isValid = validator?(text) ?? true
        isValid ? hideError() : showError()
        return isValid
    }
    
    func showError() {
        errorLabel.text = errorMessage
        errorView.isHidden = false
        textField.fieldState = .error
    }
    
    func hideError() {
        errorView.isHidden = true
        textField.fieldState = textField.isFirstResponder ? .focused : .normal
    }
    
    // MARK: - Actions
    @objc private func editingChanged() {
        guard !errorView.isHidden, validator?(text) == true else { return }
        hideError()
    }
    
    @objc private func editingEnded() {
        guard !text.isEmpty else { return }
        validate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
