//
//  OnboardingAgeController.swift
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
    
    private func makeSectionLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .ink
        return label
    }
    
    private lazy var ageLabel = makeSectionLabel("Yaş")
    private lazy var genderLabel = makeSectionLabel("Cins")
    
    private lazy var agePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return picker
    }()
    
    private lazy var genderControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Qadın", "Kişi", "Demək istəmirəm"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = .brandLime
        control.backgroundColor = .surface
        control.setTitleTextAttributes([.foregroundColor: UIColor.ink2], for: .normal)
        control.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
