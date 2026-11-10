//
//  AppTextField.swift
//  Mealli
//
//  Created by Avaz Cafarov on 07.11.26.
//

import UIKit

final class AppTextField: UITextField {
    enum FieldState {
        case normal, focused, error
    }
    
    var fieldState: FieldState = .normal {
        didSet { applyState() }
    }
    
    enum InputType {
        case name, email, password
        
        var height: CGFloat {
            switch self {
            case .name: return 64
            case .email, .password: return 52
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .name: return 18
            case .email, .password: return 12
            }
        }
        
        var font: UIFont {
            switch self {
            case .name: return .systemFont(ofSize: 24, weight: .semibold)
            case .email, .password: return AppTextStyle.body.font
            }
        }
        
        var alignment: NSTextAlignment {
            switch self {
            case .name: return .center
            case .email, .password: return .natural
            }
        }
        
        var horizontalPadding: CGFloat {
            switch self {
            case .name: return 20
            case .email, .password: return 16
            }
        }
    }
    
    private let inputType: InputType
    
    private lazy var eyeButton: UIButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let button = UIButton(frame: CGRect(x: 0, y: 4, width: 44, height: 44))
        button.setImage(UIImage(systemName: "eye", withConfiguration: config), for: .normal)
        button.tintColor = .ink2
        button.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(type: InputType = .name) {
        self.inputType = type
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        font = inputType.font
        textAlignment = inputType.alignment
        layer.cornerRadius = inputType.cornerRadius
        textColor = .ink
        backgroundColor = .surface
        heightAnchor.constraint(equalToConstant: inputType.height).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        
        switch inputType {
        case .name:
            textContentType = .name
            autocapitalizationType = .words
        case .email:
            keyboardType = .emailAddress
            textContentType = .emailAddress
            autocapitalizationType = .none
            autocorrectionType = .no
        case .password:
            isSecureTextEntry = true
            textContentType = .password
            autocapitalizationType = .none
            autocorrectionType = .no
            
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
            container.addSubview(eyeButton)
            rightView = container
            rightViewMode = .always
        }
        applyState()
    }
    
    // MARK: - State
    private func applyState() {
        switch fieldState {
        case .normal:
            layer.borderWidth = 1
            layer.borderColor = UIColor.ink3.cgColor
            layer.shadowOpacity = 0
        case .focused:
            layer.borderWidth = 2
            layer.borderColor = UIColor.brandDeep.cgColor
            layer.shadowColor = UIColor.brandLime.cgColor
            layer.shadowOffset = .zero
            layer.shadowRadius = 4
            layer.shadowOpacity = 0.8
        case .error:
            layer.borderWidth = 2
            layer.borderColor = UIColor.dangerStrong.cgColor
            layer.shadowOpacity = 0
        }
    }
    
    // MARK: - Fokus
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        if result { fieldState = .focused }
        return result
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        if result, fieldState != .error { fieldState = .normal }
        return result
    }
    
    // MARK: - Padding
    private var textInsets: UIEdgeInsets {
        let side = inputType.horizontalPadding
        return UIEdgeInsets(top: 0, left: side, bottom: 0, right: inputType == .password ? 52 : side)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
    
    // MARK: - Actions
    @objc private func eyeButtonTapped() {
        isSecureTextEntry.toggle()
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let iconName = isSecureTextEntry ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: iconName, withConfiguration: config), for: .normal)
    }
}
