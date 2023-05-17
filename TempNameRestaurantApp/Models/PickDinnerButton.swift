//
//  PickDinnerButton.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/16/23.
//

import UIKit

class PickDinnerButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }

    private func configureButton() {
        configuration = .filled()
        configuration?.baseBackgroundColor = .black
        configuration?.baseForegroundColor = .white
        configuration?.title = "Pick Dinner"
        configuration?.cornerStyle = .capsule
        configuration?.buttonSize = .large
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
