//
//  OnboardingAboutController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 03.11.26.
//

import UIKit

class OnboardingAboutController: OnboardingStepController {
    override var stepTitle: String { "Haqqında" }
    
    override var headerTitle: String {
        if let name = onboardingData?.name, !name.isEmpty {
            return "\(name), bir az özündən danış"
        }
        return "Bir az özündən danış"
    }
    
    override var headerSubtitle: String? {
        "Bunu porsiyanı və kalori ehtiyacını hesablamaq üçün soruşuruq. Heç kimlə paylaşmırıq."
    }
    
    private let ages = Array(14...90)
    private let defaultAge = 25
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Yaş"
        label.applyStyle(.label)
        return label
    }()
    
    private lazy var agePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return picker
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Cins"
        label.applyStyle(.label)
        return label
    }()
    
    private let genderControl = AppSegmentedControl(items: ["Qadın", "Kişi", "Demək istəmirəm"])
    
    private lazy var ageGenderStack: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [ageLabel, agePicker, genderLabel, genderControl])
        sV.axis = .vertical
        sV.spacing = 8
        sV.setCustomSpacing(24, after: agePicker)
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    override func setupContent() {
        contentView.addSubview(ageGenderStack)
        NSLayoutConstraint.activate([
            ageGenderStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            ageGenderStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ageGenderStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        agePicker.dataSource = self
        agePicker.delegate = self
        
        if let index = ages.firstIndex(of: defaultAge) {
            agePicker.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    override func continueTapped() {
        onboardingData?.age = ages[agePicker.selectedRow(inComponent: 0)]
        onboardingData?.gender = selectedGender()
        super.continueTapped()
    }
    
    private func selectedGender() -> OnboardingData.Gender {
        switch genderControl.selectedSegmentIndex {
        case 0: return .female
        case 1: return .male
        default: return .unspecified
        }
    }
}

extension OnboardingAboutController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(ages[row])"
    }
}
