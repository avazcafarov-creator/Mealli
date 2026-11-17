//
//  OnboardingAboutController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 03.11.26.
//

import UIKit

class OnboardingAboutController: OnboardingStepController {
    private let ages = Array(14...90)
    private let heights = Array(120...220)
    private let weights = Array(30...200)

    private let defaultAge = 25
    private let defaultHeight = 165
    private let defaultWeight = 62
    
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
    
    private enum SubStep: Int, CaseIterable { case ageGender, height, weight }
    
    private var currentSubStep: SubStep = .ageGender {
        didSet { updateSubStep() }
    }
    
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
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Boy (sm)"
        label.applyStyle(.label)
        return label
    }()
    
    private lazy var heightPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return picker
    }()
    
    private lazy var heightStack: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [heightLabel, heightPicker])
        sV.axis = .vertical
        sV.spacing = 8
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Çəki (kq)"
        label.applyStyle(.label)
        return label
    }()
    
    private lazy var weightPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return picker
    }()
    
    private lazy var weightStack: UIStackView = {
        let sV = UIStackView(arrangedSubviews: [weightLabel, weightPicker])
        sV.axis = .vertical
        sV.spacing = 8
        sV.translatesAutoresizingMaskIntoConstraints = false
        return sV
    }()
    
    override func setupContent() {
        contentView.addSubview(ageGenderStack)
        contentView.addSubview(heightStack)
        contentView.addSubview(weightStack)
        
        NSLayoutConstraint.activate([
            ageGenderStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            ageGenderStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ageGenderStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            heightStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            heightStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heightStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            weightStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            weightStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weightStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        agePicker.dataSource = self
        agePicker.delegate = self
        heightPicker.dataSource = self
        heightPicker.delegate = self
        weightPicker.dataSource = self
        weightPicker.delegate = self
        
        if let index = ages.firstIndex(of: defaultAge) {
            agePicker.selectRow(index, inComponent: 0, animated: false)
        }
        
        if let index = heights.firstIndex(of: defaultHeight) {
            heightPicker.selectRow(index, inComponent: 0, animated: false)
        }
        
        if let index = weights.firstIndex(of: defaultWeight) {
            weightPicker.selectRow(index, inComponent: 0, animated: false)
        }
        
        updateSubStep()
    }
    
    override func continueTapped() {
        if let next = SubStep(rawValue: currentSubStep.rawValue + 1) {
            currentSubStep = next
            return
        }
        onboardingData?.age = values(for: agePicker)[agePicker.selectedRow(inComponent: 0)]
        onboardingData?.gender = selectedGender()
        onboardingData?.height = values(for: heightPicker)[heightPicker.selectedRow(inComponent: 0)]
        onboardingData?.weight = values(for: weightPicker)[weightPicker.selectedRow(inComponent: 0)]
        super.continueTapped()
    }
    
    private func selectedGender() -> OnboardingData.Gender {
        switch genderControl.selectedSegmentIndex {
        case 0: return .female
        case 1: return .male
        default: return .unspecified
        }
    }
    
    private func values(for pickerView: UIPickerView) -> [Int] {
        switch pickerView {
        case heightPicker: return heights
        case weightPicker: return weights
        default: return ages
        }
    }
    
    private func updateSubStep() {
        ageGenderStack.isHidden = currentSubStep != .ageGender
        heightStack.isHidden = currentSubStep != .height
        weightStack.isHidden = currentSubStep != .weight
    }
    
    override func handleBack() -> Bool {
        if let previous = SubStep(rawValue: currentSubStep.rawValue - 1) {
            currentSubStep = previous
            return true
        }
        return false
    }
}

extension OnboardingAboutController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        values(for: pickerView).count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(values(for: pickerView)[row])"
    }
}
