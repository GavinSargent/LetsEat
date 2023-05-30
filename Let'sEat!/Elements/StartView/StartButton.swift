//
//  StartButton.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/18/23.
//

import UIKit

class StartButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    private func configureButton() {
        configuration = .tinted()
        configuration?.baseBackgroundColor = .systemBlue
        configuration?.baseForegroundColor = .systemBlue
        configuration?.title = "Begin"
        configuration?.cornerStyle = .capsule
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
