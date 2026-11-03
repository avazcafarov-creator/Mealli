//
//  ViewController.swift
//  Mealli
//
//  Created by Avaz Cafarov on 27.10.26.
//

import UIKit

class ViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mealliasdkasd"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let descriptior = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(.rounded) {
            let roundedFont = UIFont(descriptor: descriptior, size: 22)
            titleLabel.font = roundedFont
        }
    }
}

