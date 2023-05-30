//
//  PickDinnerButton.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/16/23.
//

import UIKit

class PickMealButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }

    private func configureButton() {
        configuration = .tinted()
        configuration?.baseBackgroundColor = .systemBlue
        configuration?.baseForegroundColor = .systemBlue
        configuration?.title = "Pick Meal"
        configuration?.cornerStyle = .capsule
        configuration?.buttonSize = .large
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
